from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

company_tax_codes_api = Blueprint('company_tax_codes_api', __name__)

@company_tax_codes_api.route('/get_company_tax_codes', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_company_tax_codes():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get company tax codes' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        mycursor.execute("""
            SELECT ctc.id, ctc.description, ctc.default_sales_tax_id, ctc.default_purchase_tax_id,
                   ctc.default_excise_duty_id, ctc.default_customs_duty_id, ctc.default_income_tax_id,
                   ctc.default_property_tax_id, ctc.default_corporate_tax_id, ctc.default_local_tax_id,
                   ctc.default_environmental_tax_id, ctc.default_vat_id, ctc.default_gst_id,
                   ctc.default_service_tax_id, ctc.default_excise_tax_id, ctc.default_other_tax_id,
                   ctc.default_extra_tax1_id, ctc.default_extra_tax2_id, ctc.default_extra_tax3_id,
                   ctc.default_extra_tax4_id, ctc.default_extra_tax5_id, ctc.created_at, ctc.updated_at,
                   ctc.created_by, ctc.updated_by, 
                   t1.tax_code AS default_sales_tax_code, t1.tax_rate AS default_sales_tax_rate,
                   t2.tax_code AS default_purchase_tax_code, t2.tax_rate AS default_purchase_tax_rate,
                   t3.tax_code AS default_excise_duty_code, t3.tax_rate AS default_excise_duty_rate,
                   t4.tax_code AS default_customs_duty_code, t4.tax_rate AS default_customs_duty_rate,
                   t5.tax_code AS default_income_tax_code, t5.tax_rate AS default_income_tax_rate,
                   t6.tax_code AS default_property_tax_code, t6.tax_rate AS default_property_tax_rate,
                   t7.tax_code AS default_corporate_tax_code, t7.tax_rate AS default_corporate_tax_rate,
                   t8.tax_code AS default_local_tax_code, t8.tax_rate AS default_local_tax_rate,
                   t9.tax_code AS default_environmental_tax_code, t9.tax_rate AS default_environmental_tax_rate,
                   t10.tax_code AS default_vat_code, t10.tax_rate AS default_vat_rate,
                   t11.tax_code AS default_gst_code, t11.tax_rate AS default_gst_rate,
                   t12.tax_code AS default_service_tax_code, t12.tax_rate AS default_service_tax_rate,
                   t13.tax_code AS default_excise_tax_code, t13.tax_rate AS default_excise_tax_rate,
                   t14.tax_code AS default_other_tax_code, t14.tax_rate AS default_other_tax_rate,
                   t15.tax_code AS default_extra_tax1_code, t15.tax_rate AS default_extra_tax1_rate,
                   t16.tax_code AS default_extra_tax2_code, t16.tax_rate AS default_extra_tax2_rate,
                   t17.tax_code AS default_extra_tax3_code, t17.tax_rate AS default_extra_tax3_rate,
                   t18.tax_code AS default_extra_tax4_code, t18.tax_rate AS default_extra_tax4_rate,
                   t19.tax_code AS default_extra_tax5_code, t19.tax_rate AS default_extra_tax5_rate
            FROM com.company_tax_codes ctc
            LEFT JOIN com.tax t1 ON ctc.default_sales_tax_id = t1.tax_id
            LEFT JOIN com.tax t2 ON ctc.default_purchase_tax_id = t2.tax_id
            LEFT JOIN com.tax t3 ON ctc.default_excise_duty_id = t3.tax_id
            LEFT JOIN com.tax t4 ON ctc.default_customs_duty_id = t4.tax_id
            LEFT JOIN com.tax t5 ON ctc.default_income_tax_id = t5.tax_id
            LEFT JOIN com.tax t6 ON ctc.default_property_tax_id = t6.tax_id
            LEFT JOIN com.tax t7 ON ctc.default_corporate_tax_id = t7.tax_id
            LEFT JOIN com.tax t8 ON ctc.default_local_tax_id = t8.tax_id
            LEFT JOIN com.tax t9 ON ctc.default_environmental_tax_id = t9.tax_id
            LEFT JOIN com.tax t10 ON ctc.default_vat_id = t10.tax_id
            LEFT JOIN com.tax t11 ON ctc.default_gst_id = t11.tax_id
            LEFT JOIN com.tax t12 ON ctc.default_service_tax_id = t12.tax_id
            LEFT JOIN com.tax t13 ON ctc.default_excise_tax_id = t13.tax_id
            LEFT JOIN com.tax t14 ON ctc.default_other_tax_id = t14.tax_id
            LEFT JOIN com.tax t15 ON ctc.default_extra_tax1_id = t15.tax_id
            LEFT JOIN com.tax t16 ON ctc.default_extra_tax2_id = t16.tax_id
            LEFT JOIN com.tax t17 ON ctc.default_extra_tax3_id = t17.tax_id
            LEFT JOIN com.tax t18 ON ctc.default_extra_tax4_id = t18.tax_id
            LEFT JOIN com.tax t19 ON ctc.default_extra_tax5_id = t19.tax_id
        """)

        result = mycursor.fetchall()
        company_tax_codes_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            company_tax_codes_dict = {}

            for column in columns:
                company_tax_codes_dict[column] = row[column_indices[column]]

            company_tax_codes_list.append(company_tax_codes_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved company tax codes data")

        return jsonify({'company_tax_codes_list': company_tax_codes_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving company tax codes data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
