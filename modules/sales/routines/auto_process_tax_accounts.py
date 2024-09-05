from decimal import Decimal,ROUND_HALF_UP
from modules.common.routines.get_tax_rate_by_tax_id import get_tax_rate_by_tax_id
from modules.common.routines.get_tax_rate_by_company_id import get_tax_rate_by_company_id
from modules.finance.routines.get_account_details import get_account_details
from modules.utilities.logger import logger

def auto_process_tax_accounts(order, totalamount, account_types, account_lines, USER_ID, MODULE_NAME, mydb):
    tax_id = order.get("tax_id")
    company_id = order["company_id"]
    order_has_tax_id = tax_id is not None
    order_tax_distribution_percentage = 100
    total_tax_amount = Decimal(0)
    tax_rate = Decimal(0)

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside Auto process tax accounts function  Orders ----------->: {order}")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside Auto process tax accounts function account types  ----------->: {account_types} ")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside Auto process tax accounts function account lines  ----------->: {account_lines} ")

    # Iterate through account types to get the tax type
    input_tax_types = set()
    for credit_account in account_types.get("Credit", []):
        if credit_account["category"] == "Tax":
            input_tax_types.add(credit_account["tax_type"])
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: What are the Input tax types: {input_tax_types}")
    
    if tax_id:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Processing Sales Order level tax ----------->: {tax_id}")
        tax_rate, tax_type = get_tax_rate_by_tax_id(tax_id, USER_ID, MODULE_NAME, mydb)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: What is the Input tax type before the comparison: {tax_type}")
        if tax_type not in input_tax_types:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Input tax type doesn't match with the tax id tax type")
            return total_tax_amount
        input_tax_types = {tax_type}
    else:
        new_input_tax_types = set()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: In the Sales order no tax id is found so finding tax id at company level ----------->: {tax_id}")
        for input_tax_type in input_tax_types:
            tax_id, tax_rate = get_tax_rate_by_company_id(company_id, input_tax_type, USER_ID, MODULE_NAME, mydb)
            if tax_rate:
                new_input_tax_types.add(input_tax_type)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}:company level tax_id and tax rate are found ----------->: {tax_id},---> {tax_rate} and tax types --> {input_tax_types}")
        input_tax_types = new_input_tax_types

    if not input_tax_types:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: No valid tax type found in account types")
        return total_tax_amount
    
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Now the Tax id and tax rate are: {tax_id}, {tax_rate}, tax types: {input_tax_types}")

    if tax_id and tax_rate:
        tax_amount = (Decimal(totalamount) * Decimal(tax_rate)) / Decimal(100)
        tax_amount = tax_amount.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
        total_tax_amount += tax_amount
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside if statement as tax_id and tax_rate present: {tax_id}  --> {tax_rate}")
        
        for credit_account in account_types.get("Credit", []):
            if credit_account["category"] == "Tax" and credit_account["tax_type"] in input_tax_types:
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside for loop: {tax_id}  --> {credit_account['tax_type']}")
                account_details = get_account_details(
                    company_id,
                    order["department_id"],
                    order["currency_id"],
                    credit_account["account_type"],
                    mydb,
                    USER_ID,
                    MODULE_NAME
                )
                logger.debug(f"{USER_ID} --> {MODULE_NAME}:Retruned account details ->: {account_details}")   


                if order_has_tax_id:
                    logger.debug(f"{USER_ID} --> {MODULE_NAME}: TAX ID PRESENT IN THE ORDER: ")
                    distribution_percentage = Decimal(order_tax_distribution_percentage) / 100
                    tax_allocation_amount = tax_amount * distribution_percentage

                    tax_allocation_amount = Decimal(tax_allocation_amount).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                    logger.debug(f"{USER_ID} --> {MODULE_NAME}: TO BE INSERTED TAX AMOUNT AFTER ROUNDING : {tax_allocation_amount}")
                    account_lines.append({
                        "line_number": None,
                        "account_id": int(account_details["account_id"]),
                        "debitamount": 0,
                        "is_tax_line": True,  # Add is_tax_line field
                        "creditamount": tax_allocation_amount
                    })
                    break
                else:
                    distribution_percentage = Decimal(credit_account.get("distribution_percentage", 0)) / 100
                    tax_allocation_amount = tax_amount * distribution_percentage
                    tax_allocation_amount = Decimal(tax_allocation_amount).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)                    
                    account_lines.append({
                        "line_number": None,
                        "account_id": int(account_details["account_id"]),
                        "debitamount": 0,
                        "is_tax_line": True,  # Set is_tax_line to False for debit accounts                    
                        "creditamount": tax_allocation_amount
                    })

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before returning Auto process tax accounts function  Orders ----------->: {order}")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before returning  Auto process tax accounts function account types  ----------->: {account_types} ")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before returning  Auto process tax accounts function account lines  ----------->: {account_lines} ")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before returning  Auto process tax accounts function account total tax amount  ----------->: {total_tax_amount} ")

    return total_tax_amount