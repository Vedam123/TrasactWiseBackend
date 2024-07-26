from decimal import Decimal
from modules.common.routines.get_tax_rate_by_tax_id import get_tax_rate_by_tax_id
from modules.common.routines.get_tax_rate_by_company_id import get_tax_rate_by_company_id
from modules.finance.routines.get_account_details import get_account_details
from modules.utilities.logger import logger

def auto_process_tax_accounts(order, totalamount, account_types, account_lines, USER_ID, MODULE_NAME, mydb):
    tax_id = order.get("tax_id")
    company_id = order["company_id"]
    total_tax_amount = Decimal(0)
    tax_rate = Decimal(0)

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside Auto process tax accounts function  Orders ----------->: {order}")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside Auto process tax accounts function account types  ----------->: {account_types} ")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside Auto process tax accounts function account lines  ----------->: {account_lines} ")

    # Iterate through account types to get the tax type
    input_tax_type = None
    tax_type = None
    for debit_account in account_types.get("Debit", []):
        if debit_account["category"] == "Tax":
            input_tax_type = debit_account["tax_type"]
            break
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: What is the Input tax type :  {input_tax_type}")
    if tax_id:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Processing Sales Order level tax ----------->: {tax_id}")
        tax_rate, tax_type = get_tax_rate_by_tax_id(tax_id, USER_ID, MODULE_NAME, mydb)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: What is the Input tax types  before the comparision:{tax_type}  {input_tax_type}")
        if tax_type != input_tax_type:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Input tax type doesn't match with the tax id tax type")
            return total_tax_amount
    else:
        tax_id, tax_rate = get_tax_rate_by_company_id(company_id, input_tax_type, USER_ID, MODULE_NAME, mydb)
        tax_type = input_tax_type
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Processing Company level tax ----------->: {tax_id}")

    if not tax_type:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: No tax type found in account types")
        return total_tax_amount
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Now the Tax id and tax rate as : {tax_id}, {tax_rate}, tax type : {tax_type} and input tax type : {input_tax_type}")
    if tax_id and tax_rate:
        tax_amount = (totalamount * Decimal(tax_rate))/100
        total_tax_amount = tax_amount
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside if statement as tax_id and tax_rate present: {tax_id}  --> {tax_rate}")
        for debit_account in account_types.get("Debit", []):
            if debit_account["category"] == "Tax" and debit_account["tax_type"] == tax_type :
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Inside for loop: {tax_id}  --> {tax_type} ")
                account_details = get_account_details(
                    company_id,
                    order["department_id"],
                    order["currency_id"],
                    debit_account["account_name"],
                    mydb,
                    USER_ID,
                    MODULE_NAME
                )
                distribution_percentage = Decimal(debit_account.get("distribution_percentage", 0)) / 100
                tax_allocation_amount = tax_amount * distribution_percentage
                account_lines.append({
                    "line_number": None,
                    "account_id": int(account_details["account_id"]),
                    "creditamount": 0,
                    "is_tax_line": True,  # Add is_tax_line field
                    "debitamount": tax_allocation_amount
                })

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before returning Auto process tax accounts function  Orders ----------->: {order}")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before returning  Auto process tax accounts function account types  ----------->: {account_types} ")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before returning  Auto process tax accounts function account lines  ----------->: {account_lines} ")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before returning  Auto process tax accounts function account total tax amount  ----------->: {total_tax_amount} ")

    return total_tax_amount