import re
import os
import json
import time
import requests
import pymysql

start_time = time.time()


class shopifyApp(object):

    def __init__(self):

        # self.host = os.environ['DB_HOST']
        # self.username = os.environ['DB_USER']
        # self.password = os.environ['DB_PASSWORD']
        # self.db = os.environ['DB']
        # self.port = int(os.environ['DB_PORT'])
        #
        # self.cursor = self.connect_db()
        # self.API_KEY = os.environ['SHOPIFY_API_KEY']
        # self.API_PASS = os.environ['SHOPIFY_API_PASSWORD']

        self.host = '107.170.209.55'
        self.username = 'remote'
        self.password = 'remote'
        self.db = 'mega'
        self.port = 3306
        self.cursor = self.connect_db()
        self.API_KEY = 'a02c2d6ff59722b9d3f1d52bca7623f7'
        self.API_PASS = 'f56822e5446730dc4a7dfbe6ead42218'


        self.shopify_api = "https://%s:%s@megalopolis-toys.myshopify.com/admin/orders.json/?published_status=published&" \
                           "limit=250&page=%s"

    def connect_db(self):
        print('connect')
        cnx = {'host': self.host,
               'username': self.username,
               'password': self.password,
               'db': self.db,
               'port': int(self.port)
               }
        self.conn = pymysql.connect(db=cnx['db'], host=cnx['host'], port=cnx['port'], user=cnx['username'],
                                    password=cnx['password'])
        self.cursor = self.conn.cursor()
        return self.cursor

    def connect_shopify(self, i):
        print('shopify')
        json_resp_data = {}
        shopify_api = self.shopify_api % (self.API_KEY, self.API_PASS, i)

        try:
            resp_data = requests.get(shopify_api)
            print(resp_data)
            if resp_data.status_code == 200:
                json_resp_data = json.loads(resp_data.text)
        except Exception as e:
            print(e)
        return json_resp_data

    def save_order(self, i):
        print('save')
        def add_quote(w):
            return '"{}"'.format(w)

        self.shopify_data = self.connect_shopify(i)
        try:
            for data in self.shopify_data['orders']:
                json_body = add_quote(re.escape(format(data)))
                order_id = add_quote(data.get('id')) if data.get('id') else 'Null'
                email = add_quote(data.get('email')) if data.get('email') else 'Null'
                closedat = add_quote(data.get('closed_at')) if data.get('closed_at') else 'Null'
                createdat = add_quote(data.get('created_at')) if data.get('created_at') else 'Null'
                updatedat = add_quote(data.get('updated_at')) if data.get('updated_at') else 'Null'
                number = add_quote(data.get('number')) if data.get('number') else 'Null'
                note = add_quote(data.get('note')) if data.get('note') else 'Null'
                token = add_quote(data.get('token')) if data.get('token') else 'Null'
                gateway = add_quote(data.get('gateway')) if data.get('gateway') else 'Null'
                test = add_quote(data.get('test')) if data.get('test') else 'Null'
                totalprice = add_quote(data.get('total_price')) if data.get('total_price') else 'Null'
                subtotalprice = add_quote(data.get('subtotal_price')) if data.get('subtotal_price') else 'Null'
                totalweight = add_quote(data.get('total_weight')) if data.get('total_weight') else 'Null'
                totaltax = add_quote(data.get('total_tax')) if data.get('total_tax') else 'Null'
                taxesincluded = add_quote(data.get('taxes_included')) if data.get('taxes_included') else 'Null'
                currency = add_quote(data.get('currency')) if data.get('currency') else 'Null'
                financialstatus = add_quote(data.get('financial_status')) if data.get('financial_status') else 'Null'
                confirmed = add_quote(data.get('confirmed')) if data.get('confirmed') else 'Null'
                totaldiscounts = add_quote(data.get('total_discounts')) if data.get('total_discounts') else 'Null'
                totallineitemsprice = add_quote(data.get('total_line_items_price')) if data.get('total_line_items_price') else 'Null'
                carttoken = add_quote(data.get('cart_token')) if data.get('cart_token') else 'Null'
                buyeracceptsmarketing = add_quote(data.get('buyer_accepts_marketing')) if data.get('buyer_accepts_marketing') else 'Null'
                name = add_quote(data.get('name')) if data.get('name') else 'Null'
                referringsite = add_quote(data.get('referring_site')) if data.get('referring_site') else 'Null'
                landingsite = add_quote(data.get('landing_site')) if data.get('landing_site') else 'Null'
                cancelledat = add_quote(data.get('cancelled_at')) if data.get('cancelled_at') else 'Null'
                cancelreason = add_quote(data.get('cancel_reason')) if data.get('cancel_reason') else 'Null'
                totalpriceusd = add_quote(data.get('total_price_usd')) if data.get('total_price_usd') else 'Null'
                checkouttoken = add_quote(data.get('checkout_token')) if data.get('checkout_token') else 'Null'
                reference = add_quote(data.get('reference')) if data.get('reference') else 'Null'
                userid = add_quote(data.get('user_id')) if data.get('user_id') else 'Null'
                locationid = add_quote(data.get('location_id')) if data.get('location_id') else 'Null'
                sourceidentifier = add_quote(data.get('source_identifier')) if data.get('source_identifier') else 'Null'
                sourceurl = add_quote(data.get('source_url')) if data.get('source_url') else 'Null'
                processedat = add_quote(data.get('processed_at')) if data.get('processed_at') else 'Null'
                deviceid = add_quote(data.get('device_id')) if data.get('device_id') else 'Null'
                phone = add_quote(data.get('phone')) if data.get('phone') else 'Null'
                customerlocale = add_quote(data.get('customer_locale')) if data.get('customer_locale') else 'Null'
                appid = add_quote(data.get('app_id')) if data.get('app_id') else 'Null'
                browserip = add_quote(data.get('browser_ip')) if data.get('browser_ip') else 'Null'
                landingsiteref = add_quote(data.get('landing_site_ref')) if data.get('landing_site_ref') else 'Null'
                ordernumber = add_quote(data.get('order_number')) if data.get('order_number') else 'Null'
                discountapplicationstype = add_quote(data.get('discount_applications')[0].get('type')) if len(data.get('discount_applications')) > 0 and data.get('discount_applications')[0].get('type') else 'Null'
                discountapplicationsvalue = add_quote(data.get('discount_applications')[0].get('value')) if len(data.get('discount_applications')) > 0 and data.get('discount_applications')[0].get('value') else 'Null'
                discountapplicationsvaluetype = add_quote(data.get('discount_applications')[0].get('value_type')) if len(data.get('discount_applications')) > 0 and data.get('discount_applications')[0].get('value_type') else 'Null'
                discountapplicationsallocationmethod = add_quote(data.get('discount_applications')[0].get('allocation_method')) if len(data.get('discount_applications')) > 0 and data.get('discount_applications')[0].get('allocation_method') else 'Null'
                discountapplicationstargetselection = add_quote(data.get('discount_applications')[0].get('target_selection')) if len(data.get('discount_applications')) > 0 and data.get('discount_applications')[0].get('target_selection') else 'Null'
                discountapplicationstargettype = add_quote(data.get('discount_applications')[0].get('target_type')) if len(data.get('discount_applications')) > 0 and data.get('discount_applications')[0].get('target_type') else 'Null'
                discountapplicationscode = add_quote(data.get('discount_applications')[0].get('code')) if len(data.get('discount_applications')) > 0 and data.get('discount_applications')[0].get('code') else 'Null'
                discountcodescode = add_quote(data.get('discount_codes')[0].get('code')) if len(data.get('discount_codes')) > 0 and data.get('discount_codes')[0].get('code') else 'Null'
                discountcodesamount = add_quote(data.get('discount_codes')[0].get('amount')) if len(data.get('discount_codes')) > 0 and data.get('discount_codes')[0].get('amount') else 'Null'
                discountcodestype = add_quote(data.get('discount_codes')[0].get('type')) if len(data.get('discount_codes')) > 0 and data.get('discount_codes')[0].get('type') else 'Null'
                paymentgatewaynames = add_quote(data.get('payment_gateway_names')[0]) if len(data.get('payment_gateway_names')) > 0 else 'Null'
                processingmethod = add_quote(data.get('processing_method')) if data.get('processing_method') else 'Null'
                checkoutid = add_quote(data.get('checkout_id')) if data.get('checkout_id') else 'Null'
                sourcename = add_quote(data.get('source_name')) if data.get('source_name') else 'Null'
                fulfillmentstatus = add_quote(data.get('fulfillment_status')) if data.get('fulfillment_status') else 'Null'
                taxlinesprice = add_quote(data.get('tax_lines')[0].get('price')) if len(data.get('tax_lines')) > 0 and data.get('tax_lines')[0].get('price') else 'Null'
                taxlinesrate = add_quote(data.get('tax_lines')[0].get('rate')) if len(data.get('tax_lines')) > 0 and data.get('tax_lines')[0].get('rate') else 'Null'
                taxlinestitle = add_quote(data.get('tax_lines')[0].get('title')) if len(data.get('tax_lines')) > 0 and data.get('tax_lines')[0].get('title') else 'Null'
                tags = add_quote(data.get('tags')) if data.get('tags') else 'Null'
                contactemail = add_quote(data.get('contact_email')) if data.get('contact_email') else 'Null'
                orderstatusurl = add_quote(data.get('order_status_url')) if data.get('order_status_url') else 'Null'
                admingraphqlapiid = add_quote(data.get('admin_graphql_api_id')) if data.get('admin_graphql_api_id') else 'Null'

                self.cursor.execute("""CALL mega.save_order({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                                            {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                                            {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                                            {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {})"""
                    .format(
                    order_id,
                    email,
                    closedat,
                    createdat,
                    updatedat,
                    number,
                    note,
                    token,
                    gateway,
                    test,
                    totalprice,
                    subtotalprice,
                    totalweight,
                    totaltax,
                    taxesincluded,
                    currency,
                    financialstatus,
                    confirmed,
                    totaldiscounts,
                    totallineitemsprice,
                    carttoken,
                    buyeracceptsmarketing,
                    name,
                    referringsite,
                    landingsite,
                    cancelledat,
                    cancelreason,
                    totalpriceusd,
                    checkouttoken,
                    reference,
                    userid,
                    locationid,
                    sourceidentifier,
                    sourceurl,
                    processedat,
                    deviceid,
                    phone,
                    customerlocale,
                    appid,
                    browserip,
                    landingsiteref,
                    ordernumber,
                    discountapplicationstype,
                    discountapplicationsvalue,
                    discountapplicationsvaluetype,
                    discountapplicationsallocationmethod,
                    discountapplicationstargetselection,
                    discountapplicationstargettype,
                    discountapplicationscode,
                    discountcodescode,
                    discountcodesamount,
                    discountcodestype,
                    paymentgatewaynames,
                    processingmethod,
                    checkoutid,
                    sourcename,
                    fulfillmentstatus,
                    taxlinesprice,
                    taxlinesrate,
                    taxlinestitle,
                    tags,
                    contactemail,
                    orderstatusurl,
                    admingraphqlapiid,
                    json_body))
                # print('> Orders saved')
                self.conn.commit()
                # self.save_customers(order_id)
            print('> Orders saved', i)
        except Exception as e:
            print(e)

    def save_order_details(self, i):
        def add_quote(w):
            return '"{}"'.format(w)

        self.shopify_data = self.connect_shopify(i)
        try:
            for data in self.shopify_data['orders']:
                billing = {}
                shipping = {}
                _order_id = add_quote(data.get('id')) if data.get('id') else 'Null'

                if 'billing_address' in data:
                    billing_data = data.get('billing_address')
                    billing['_address_type'] = add_quote('billing')
                    billing['_shopify_address_id'] = 'Null'
                    billing['_first_name'] = add_quote(billing_data.get('first_name')) if billing_data.get(
                        'first_name') and billing_data.get('first_name') != '' else 'Null'
                    billing['_last_name'] = add_quote(billing_data.get('last_name')) if billing_data.get(
                        'last_name') and billing_data.get('last_name') != '' else 'Null'
                    billing['_company'] = add_quote(billing_data.get('company')) if billing_data.get(
                        'company') and billing_data.get('company') != '' else 'Null'
                    billing['_address1'] = add_quote(billing_data.get('address1')) if billing_data.get(
                        'address1') and billing_data.get('address1') != '' else 'Null'
                    billing['_address2'] = add_quote(billing_data.get('address2')) if billing_data.get(
                        'address2') and billing_data.get('address1') != '' else 'Null'
                    billing['_city'] = add_quote(billing_data.get('city')) if billing_data.get(
                        'city') and billing_data.get('city') != '' else 'Null'
                    billing['_zip'] = add_quote(billing_data.get('zip')) if billing_data.get('zip') and billing_data.get(
                        'zip') != '' else 'Null'
                    billing['_province'] = add_quote(billing_data.get('province')) if billing_data.get(
                        'province') and billing_data.get('province') != '' else 'Null'
                    billing['_province_code'] = add_quote(billing_data.get('province_code')) if billing_data.get(
                        'province_code') and billing_data.get('province_code') != '' else 'Null'
                    billing['_country'] = add_quote(billing_data.get('country')) if billing_data.get(
                        'country') and billing_data.get('country') != '' else 'Null'
                    billing['_country_code'] = add_quote(billing_data.get('country_code')) if billing_data.get(
                        'country_code') and billing_data.get('country_code') != '' else 'Null'
                    billing['_phone'] = add_quote(billing_data.get('phone')) if billing_data.get(
                        'phone') and billing_data.get('phone') != '' else 'Null'
                    billing['_latitude'] = add_quote(billing_data.get('latitude')) if billing_data.get(
                        'latitude') and billing_data.get('latitude') != '' else 'Null'
                    billing['_longitude'] = add_quote(billing_data.get('longitude')) if billing_data.get(
                        'longitude') and billing_data.get('longitude') != '' else 'Null'
                    # print(billing['_longitude'])

                    self.commit_order_address(billing, _order_id)

                if 'shipping_address' in data:
                    shipping_data = data.get('shipping_address')
                    shipping['_address_type'] = add_quote('shipping')
                    shipping['_shopify_address_id'] = 'Null'
                    shipping['_first_name'] = add_quote(shipping_data.get('first_name')) if shipping_data.get(
                        'first_name') and shipping_data.get('first_name') != '' else 'Null'
                    shipping['_last_name'] = add_quote(shipping_data.get('last_name')) if shipping_data.get(
                        'last_name') and shipping_data.get('last_name') != '' else 'Null'
                    shipping['_company'] = add_quote(shipping_data.get('company')) if shipping_data.get(
                        'company') and shipping_data.get('company') != '' else 'Null'
                    shipping['_address1'] = add_quote(shipping_data.get('address1')) if shipping_data.get(
                        'address1') and shipping_data.get('address1') != '' else 'Null'
                    shipping['_address2'] = add_quote(shipping_data.get('address2')) if shipping_data.get(
                        'address2') and shipping_data.get('address1') != '' else 'Null'
                    shipping['_city'] = add_quote(shipping_data.get('city')) if shipping_data.get(
                        'city') and shipping_data.get(
                        'city') != '' else 'Null'
                    shipping['_zip'] = add_quote(shipping_data.get('zip')) if shipping_data.get(
                        'zip') and shipping_data.get(
                        'zip') != '' else 'Null'
                    shipping['_province'] = add_quote(shipping_data.get('province')) if shipping_data.get(
                        'province') and shipping_data.get('province') != '' else 'Null'
                    shipping['_province_code'] = add_quote(shipping_data.get('province_code')) if shipping_data.get(
                        'province_code') and shipping_data.get('province_code') != '' else 'Null'
                    shipping['_country'] = add_quote(shipping_data.get('country')) if shipping_data.get(
                        'country') and shipping_data.get('country') != '' else 'Null'
                    shipping['_country_code'] = add_quote(shipping_data.get('country_code')) if shipping_data.get(
                        'country_code') and shipping_data.get('country_code') != '' else 'Null'
                    shipping['_phone'] = add_quote(shipping_data.get('phone')) if shipping_data.get(
                        'phone') and shipping_data.get(
                        'phone') != '' else 'Null'
                    shipping['_latitude'] = add_quote(shipping_data.get('latitude')) if shipping_data.get(
                        'latitude') and shipping_data.get('latitude') != '' else 'Null'
                    shipping['_longitude'] = add_quote(shipping_data.get('longitude')) if shipping_data.get(
                        'longitude') and shipping_data.get('longitude') != '' else 'Null'
                    self.commit_order_address(shipping, _order_id)

                if 'customer' in data:
                    customer_data = data.get('customer')
                    customer_data['customer_id'] = add_quote(customer_data.get('id')) if customer_data.get('id') and customer_data.get('id') != '' else 'Null'
                    customer_data['email'] = add_quote(customer_data.get('email')) if customer_data.get('email') and customer_data.get('email') != '' else 'Null'
                    customer_data['accepts_marketing'] = add_quote(customer_data.get('accepts_marketing')) if customer_data.get('accepts_marketing') and customer_data.get('accepts_marketing') != '' else 'Null'
                    customer_data['created_at'] = add_quote(customer_data.get('created_at')) if customer_data.get('created_at') and customer_data.get('created_at') != '' else 'Null'
                    customer_data['updated_at'] = add_quote(customer_data.get('updated_at')) if customer_data.get('updated_at') and customer_data.get('updated_at') != '' else 'Null'
                    customer_data['first_name'] = add_quote(customer_data.get('first_name')) if customer_data.get('first_name') and customer_data.get('first_name') != '' else 'Null'
                    customer_data['last_name'] = add_quote(customer_data.get('last_name')) if customer_data.get('last_name') and customer_data.get('last_name') != '' else 'Null'
                    customer_data['state'] = add_quote(customer_data.get('state')) if customer_data.get('state') and customer_data.get('state') != '' else 'Null'
                    customer_data['note'] = add_quote(customer_data.get('note')) if customer_data.get('note') and customer_data.get('note') != '' else 'Null'
                    customer_data['verified_email'] = add_quote(customer_data.get('verified_email')) if customer_data.get('verified_email') and customer_data.get('verified_email') != '' else 'Null'
                    customer_data['multipass_identifier'] = add_quote(customer_data.get('multipass_identifier')) if customer_data.get('multipass_identifier') and customer_data.get('multipass_identifier') != '' else 'Null'
                    customer_data['tax_exempt'] = add_quote(customer_data.get('tax_exempt')) if customer_data.get('tax_exempt') and customer_data.get('tax_exempt') != '' else 'Null'
                    customer_data['phone'] = add_quote(customer_data.get('phone')) if customer_data.get('phone') and customer_data.get('phone') != '' else 'Null'
                    customer_data['tags'] = add_quote(customer_data.get('tags')) if customer_data.get('tags') and customer_data.get('tags') != '' else 'Null'
                    customer_data['admin_graphql_api_id'] = add_quote(customer_data.get('admin_graphql_api_id')) if customer_data.get('admin_graphql_api_id') and customer_data.get('admin_graphql_api_id') != '' else 'Null'
                    customer_data['default_address_id'] = add_quote(customer_data.get('default_address', {}).get('id')) if customer_data.get('default_address', {}).get('id') and customer_data.get('default_address', {}).get('id') != '' else 'Null'
                    customer_data['default_address_first_name'] = add_quote(customer_data.get('default_address', {}).get('first_name')) if customer_data.get('default_address', {}).get('first_name') and customer_data.get('default_address', {}).get('first_name') != '' else 'Null'
                    customer_data['default_address_last_name'] = add_quote(customer_data.get('default_address', {}).get('last_name ')) if customer_data.get('default_address', {}).get('last_name') and customer_data.get('default_address', {}).get('last_name ') != '' else 'Null'
                    customer_data['default_address_company'] = add_quote(customer_data.get('default_address', {}).get('company ')) if customer_data.get('default_address', {}).get('company') and customer_data.get('default_address', {}).get('company') and customer_data.get('default_address', {}).get('company ') != '' else 'Null'
                    customer_data['default_address_address1'] = add_quote(customer_data.get('default_address', {}).get('address1')) if customer_data.get('default_address', {}).get('address1') and customer_data.get('default_address', {}).get('address1') != '' else 'Null'
                    customer_data['default_address_address2'] = add_quote(customer_data.get('default_address', {}).get('address2')) if customer_data.get('default_address', {}).get('address2') and customer_data.get('default_address', {}).get('address2') != '' else 'Null'
                    customer_data['default_address_city'] = add_quote(customer_data.get('default_address', {}).get('city')) if customer_data.get('default_address', {}).get('city') and customer_data.get('default_address', {}).get('city') != '' else 'Null'
                    customer_data['default_address_province'] = add_quote(customer_data.get('default_address', {}).get('province')) if customer_data.get('default_address', {}).get('province') and customer_data.get('default_address', {}).get('province') != '' else 'Null'
                    customer_data['default_address_country'] = add_quote(customer_data.get('default_address', {}).get('country')) if customer_data.get('default_address', {}).get('country') and customer_data.get('default_address', {}).get('country') != '' else 'Null'
                    customer_data['default_address_zip'] = add_quote(customer_data.get('default_address', {}).get('zip')) if customer_data.get('default_address', {}).get('zip') and customer_data.get('default_address', {}).get('zip') != '' else 'Null'
                    customer_data['default_address_phone'] = add_quote(customer_data.get('default_address', {}).get('phone')) if customer_data.get('default_address', {}).get('phone') and customer_data.get('default_address', {}).get('phone') != '' else 'Null'
                    customer_data['default_address_province_code'] = add_quote(customer_data.get('default_address', {}).get('province_code')) if customer_data.get('default_address', {}).get('province_code') and customer_data.get('default_address', {}).get('province_code') != '' else 'Null'
                    customer_data['default_address_country_code'] = add_quote(customer_data.get('default_address', {}).get('country_code')) if customer_data.get('default_address', {}).get('country_code') and customer_data.get('default_address', {}).get('country_code') != '' else 'Null'
                    customer_data['default_address_country_name'] = add_quote(customer_data.get('default_address', {}).get('country_name')) if customer_data.get('default_address', {}).get('country_name') and customer_data.get('default_address', {}).get('country_name') != '' else 'Null'
                    self.save_customers(customer_data, _order_id)

            print('> Orders addresses saved', i)
        except Exception as e:
            print(e)

    def commit_order_address(self, address, order_id):
        self.cursor.execute(
            """CALL mega.save_order_address({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {})"""
                .format(
                order_id,
                address['_address_type'],
                address['_shopify_address_id'],
                address['_first_name'],
                address['_last_name'],
                address['_company'],
                address['_address1'],
                address['_address2'],
                address['_city'],
                address['_zip'],
                address['_province'],
                address['_province_code'],
                address['_country'],
                address['_country_code'],
                address['_phone'],
                address['_latitude'],
                address['_longitude']))
        self.conn.commit()

    def save_customers(self, customer_data, order_id):
        self.cursor.execute(
            """CALL mega.save_customer({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                       {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {})"""
                .format(
                customer_data['customer_id'],
                order_id,
                customer_data['email'],
                customer_data['accepts_marketing'],
                customer_data['created_at'],
                customer_data['updated_at'],
                customer_data['first_name'],
                customer_data['last_name'],
                customer_data['state'],
                customer_data['note'],
                customer_data['verified_email'],
                customer_data['multipass_identifier'],
                customer_data['tax_exempt'],
                customer_data['phone'],
                customer_data['tags'],
                customer_data['admin_graphql_api_id'],
                customer_data['default_address_id'],
                customer_data['default_address_first_name'],
                customer_data['default_address_last_name'],
                customer_data['default_address_company'],
                customer_data['default_address_address1'],
                customer_data['default_address_address2'],
                customer_data['default_address_city'],
                customer_data['default_address_province'],
                customer_data['default_address_country'],
                customer_data['default_address_zip'],
                customer_data['default_address_phone'],
                customer_data['default_address_province_code'],
                customer_data['default_address_country_code'],
                customer_data['default_address_country_name']))
        self.conn.commit()

    def save_order_line_item(self, i):
        def add_quote(w):
            return '"{}"'.format(w)

        self.shopify_data = self.connect_shopify(i)
        try:
            for data in self.shopify_data['orders']:
                order_id = add_quote(data.get('id')) if data.get('id') else 'Null'
                if 'line_items' in data:
                    for line_data in data['line_items']:
                        id = add_quote(line_data.get('id')) if line_data.get('id') and line_data.get(
                            'id') != '' else 'Null'
                        variant_id = add_quote(line_data.get('variant_id')) if line_data.get('variant_id') and line_data.get(
                            'variant_id') != '' else 'Null'
                        title = add_quote(line_data.get('title').replace('\"', '')) if line_data.get('title') and line_data.get(
                            'title') != '' else 'Null'
                        quantity = add_quote(line_data.get('quantity')) if line_data.get('quantity') and line_data.get(
                            'quantity') != '' else 'Null'
                        price = add_quote(line_data.get('price')) if line_data.get('price') and line_data.get(
                            'price') != '' else 'Null'
                        sku = add_quote(line_data.get('sku')) if line_data.get('sku') and line_data.get(
                            'sku') != '' else 'Null'
                        variant_title = add_quote(line_data.get('variant_title')) if line_data.get('variant_title') and line_data.get(
                            'variant_title') != '' else 'Null'
                        vendor = add_quote(line_data.get('vendor')) if line_data.get('vendor') and line_data.get(
                            'vendor') != '' else 'Null'
                        fulfillment_service = add_quote(line_data.get('fulfillment_service')) if line_data.get('fulfillment_service') and line_data.get(
                            'fulfillment_service') != '' else 'Null'
                        product_id = add_quote(line_data.get('product_id')) if line_data.get('product_id') and line_data.get(
                            'product_id') != '' else 'Null'
                        requires_shipping = add_quote(line_data.get('requires_shipping')) if line_data.get('requires_shipping') and line_data.get(
                            'requires_shipping') != '' else 'Null'
                        taxable = add_quote(line_data.get('taxable')) if line_data.get('taxable') and line_data.get(
                            'taxable') != '' else 'Null'
                        gift_card = add_quote(line_data.get('gift_card')) if line_data.get('gift_card') and line_data.get(
                            'gift_card') != '' else 'Null'
                        name = add_quote(line_data.get('name').replace('\"', '')) if line_data.get('name') and line_data.get(
                            'id') != '' else 'Null'
                        variant_inventory_management = add_quote(line_data.get('variant_inventory_management')) if line_data.get(
                            'variant_inventory_management') and line_data.get('variant_inventory_management') != '' else 'Null'
                        product_exists = add_quote(line_data.get('product_exists')) if line_data.get('product_exists') and line_data.get(
                            'product_exists') != '' else 'Null'
                        fulfillable_quantity = add_quote(line_data.get('fulfillable_quantity')) if line_data.get('fulfillable_quantity') and line_data.get(
                            'fulfillable_quantity') != '' else 'Null'
                        grams = add_quote(line_data.get('grams')) if line_data.get('grams') and line_data.get(
                            'grams') != '' else 'Null'
                        total_discount = add_quote(line_data.get('total_discount')) if line_data.get('total_discount') and line_data.get(
                            'total_discount') != '' else 'Null'
                        fulfillment_status = add_quote(line_data.get('fulfillment_status')) if line_data.get('fulfillment_status') and line_data.get(
                            'fulfillment_status') != '' else 'Null'
                        discount_allocations = add_quote(line_data.get('discount_allocations')) if line_data.get('discount_allocations') and line_data.get(
                            'id') != '' else 'Null'
                        admin_graphql_api_id = add_quote(line_data.get('id')) if line_data.get('id') and line_data.get(
                            'discount_allocations') != '' else 'Null'
                        tax_lines_title = add_quote(line_data.get('tax_lines_title')) if line_data.get('tax_lines_title') and line_data.get(
                            'id') != '' else 'Null'
                        tax_lines_price = add_quote(line_data.get('tax_lines_price')) if line_data.get('tax_lines_price') and line_data.get(
                            'tax_lines_price') != '' else 'Null'
                        tax_lines_rate = add_quote(line_data.get('tax_lines_rate')) if line_data.get('tax_lines_rate') and line_data.get(
                            'tax_lines_rate') != '' else 'Null'
                        origin_allocation_id = add_quote(
                            line_data.get('origin_allocation', {}).get('id')) if line_data.get('origin_allocation', {}).get(
                            'id') and line_data.get('origin_allocation', {}).get('id') != '' else 'Null'
                        origin_allocation_country_code = add_quote(
                            line_data.get('origin_allocation', {}).get('country_code')) if line_data.get('origin_allocation', {}).get(
                            'country_code') and line_data.get('origin_allocation', {}).get('country_code') != '' else 'Null'
                        origin_allocation_province_code = add_quote(
                            line_data.get('origin_allocation', {}).get('province_code')) if line_data.get('origin_allocation', {}).get(
                            'province_code') and line_data.get('origin_allocation', {}).get('province_code') != '' else 'Null'
                        origin_allocation_name = add_quote(
                            line_data.get('origin_allocation', {}).get('nam')) if line_data.get('origin_allocation', {}).get(
                            'nam') and line_data.get('origin_allocation', {}).get('nam') != '' else 'Null'
                        origin_allocation_address1 = add_quote(
                            line_data.get('origin_allocation', {}).get('address1')) if line_data.get('origin_allocation', {}).get(
                            'address1') and line_data.get('origin_allocation', {}).get('address1') != '' else 'Null'
                        origin_allocation_address2 = add_quote(
                            line_data.get('origin_allocation', {}).get('address2')) if line_data.get('origin_allocation', {}).get(
                            'address2') and line_data.get('origin_allocation', {}).get('address2') != '' else 'Null'
                        origin_allocation_city = add_quote(
                            line_data.get('origin_allocation', {}).get('city')) if line_data.get('origin_allocation', {}).get(
                            'city') and line_data.get('origin_allocation', {}).get('city') != '' else 'Null'
                        origin_allocation_zip = add_quote(
                            line_data.get('origin_allocation', {}).get('zip')) if line_data.get('origin_allocation', {}).get(
                            'zip') and line_data.get('origin_allocation', {}).get('zip') != '' else 'Null'
                        self.cursor.execute("""CALL mega.save_order_line_item({}, {}, {}, {}, {},{}, {}, {}, {}, {},{},
                                                                              {}, {}, {}, {},{}, {}, {}, {}, {},{}, {},
                                                                              {}, {}, {},{}, {}, {}, {}, {},{}, {}, {}, {})"""
                            .format(
                            id,
                            order_id,
                            variant_id,
                            title,
                            quantity,
                            price,
                            sku,
                            variant_title,
                            vendor,
                            fulfillment_service,
                            product_id,
                            requires_shipping,
                            taxable,
                            gift_card,
                            name,
                            variant_inventory_management,
                            product_exists,
                            fulfillable_quantity,
                            grams,
                            total_discount,
                            fulfillment_status,
                            discount_allocations,
                            admin_graphql_api_id,
                            tax_lines_title,
                            tax_lines_price,
                            tax_lines_rate,
                            origin_allocation_id,
                            origin_allocation_country_code,
                            origin_allocation_province_code,
                            origin_allocation_name,
                            origin_allocation_address1,
                            origin_allocation_address2,
                            origin_allocation_city,
                            origin_allocation_zip))
                        self.conn.commit()
            print('> Order items saved',i)
        except Exception as e:
            print(e)


def main(event, context):
    sa = shopifyApp()
    sa.save_order(1)
    sa.save_order_details(1)
    sa.save_order_line_item(1)
    # max_count = 1
    # for i in range(1, max_count):
    #     sa.save_order(i)
    #     sa.save_order_details(i)
    #     sa.save_order_line_item(i)
    #     print("--- execution time: %s seconds ---" % (time.time() - start_time))


if __name__ == "__main__":
    main(0, 0)