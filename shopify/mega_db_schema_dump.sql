/*
Navicat MySQL Data Transfer

Source Server         : 107.170.209.55
Source Server Version : 50723
Source Host           : 107.170.209.55:3306
Source Database       : mega

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2018-10-06 00:34:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _invoice
-- ----------------------------
DROP TABLE IF EXISTS `_invoice`;
CREATE TABLE `_invoice` (
  `id` int(11) NOT NULL,
  `ref_no` varchar(20) DEFAULT NULL,
  `shipment_id` int(11) DEFAULT NULL,
  `_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `supplier_billing_address_id` int(11) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `supplier_billing_address_id` (`supplier_billing_address_id`) USING BTREE,
  KEY `shipment_id` (`shipment_id`) USING BTREE,
  CONSTRAINT `_invoice_ibfk_3` FOREIGN KEY (`supplier_billing_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `_invoice_ibfk_4` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shopify_address_id` bigint(20) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `business_entity_id` int(11) DEFAULT NULL,
  `is_billing` tinyint(1) DEFAULT NULL,
  `is_shipping` tinyint(1) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL DEFAULT '',
  `last_name` varchar(50) NOT NULL DEFAULT '',
  `company` varchar(50) NOT NULL DEFAULT '',
  `address1` varchar(150) NOT NULL DEFAULT '',
  `address2` varchar(150) NOT NULL DEFAULT '',
  `city` varchar(50) NOT NULL DEFAULT '',
  `zip` varchar(10) NOT NULL DEFAULT '',
  `province` varchar(30) NOT NULL DEFAULT '',
  `province_code` varchar(10) NOT NULL DEFAULT '',
  `country` varchar(30) NOT NULL DEFAULT '',
  `country_code` varchar(10) NOT NULL DEFAULT '',
  `phone` varchar(20) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `first_name` (`first_name`,`last_name`,`address1`,`address2`,`city`,`zip`,`province_code`,`country_code`,`company`) USING BTREE,
  UNIQUE KEY `shopify_id` (`shopify_address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5191 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for business_entity
-- ----------------------------
DROP TABLE IF EXISTS `business_entity`;
CREATE TABLE `business_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `legal_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `accepts_marketing` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `note` text,
  `verified_email` varchar(10) DEFAULT NULL,
  `multipass_identifier` varchar(50) DEFAULT NULL,
  `tax_exempt` varchar(10) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `tags` varchar(150) DEFAULT NULL,
  `admin_graphql_api_id` varchar(100) DEFAULT NULL,
  `default_address_id` bigint(20) DEFAULT NULL,
  `default_address_first_name` varchar(50) DEFAULT NULL,
  `default_address_last_name` varchar(50) DEFAULT NULL,
  `default_address_company` varchar(50) DEFAULT NULL,
  `default_address_address1` varchar(150) DEFAULT NULL,
  `default_address_address2` varchar(150) DEFAULT NULL,
  `default_address_city` varchar(50) DEFAULT NULL,
  `default_address_province` varchar(30) DEFAULT NULL,
  `default_address_country` varchar(30) DEFAULT NULL,
  `default_address_zip` varchar(10) DEFAULT NULL,
  `default_address_phone` varchar(20) DEFAULT NULL,
  `default_address_province_code` varchar(10) DEFAULT NULL,
  `default_address_country_code` varchar(10) DEFAULT NULL,
  `default_address_country_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for invoice
-- ----------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `id` bigint(20) DEFAULT NULL,
  `ref_no` varchar(30) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `invoice_due_date` date DEFAULT NULL,
  `invoice_paid_date` date DEFAULT NULL,
  `vendor_name` varchar(50) DEFAULT NULL,
  `account_number` varchar(30) DEFAULT NULL,
  `bill_to_address` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ship_to_address` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `pro_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `terms` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `shipping` decimal(19,4) DEFAULT NULL,
  `tax` decimal(19,4) DEFAULT NULL,
  `pd_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pd_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for invoice_item
-- ----------------------------
DROP TABLE IF EXISTS `invoice_item`;
CREATE TABLE `invoice_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint(20) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `uom` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `cost` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `invoice_item_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for order_line_item
-- ----------------------------
DROP TABLE IF EXISTS `order_line_item`;
CREATE TABLE `order_line_item` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `variant_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(19,4) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `variant_title` varchar(50) DEFAULT NULL,
  `vendor` varchar(50) DEFAULT NULL,
  `fulfillment_service` varchar(50) DEFAULT NULL,
  `product_id` bigint(11) DEFAULT NULL,
  `requires_shipping` varchar(50) DEFAULT NULL,
  `taxable` varchar(50) DEFAULT NULL,
  `gift_card` varchar(50) DEFAULT NULL,
  `_name` varchar(150) DEFAULT NULL,
  `variant_inventory_management` varchar(50) DEFAULT NULL,
  `product_exists` varchar(255) DEFAULT NULL,
  `fulfillable_quantity` int(11) DEFAULT NULL,
  `grams` int(11) DEFAULT NULL,
  `total_discount` decimal(19,4) DEFAULT NULL,
  `fulfillment_status` varchar(50) DEFAULT NULL,
  `discount_allocations` varchar(255) DEFAULT NULL,
  `admin_graphql_api_id` varchar(100) DEFAULT NULL,
  `tax_lines_title` varchar(50) DEFAULT NULL,
  `tax_lines_price` decimal(19,4) DEFAULT NULL,
  `tax_lines_rate` decimal(19,4) DEFAULT NULL,
  `origin_allocation_id` bigint(20) DEFAULT NULL,
  `origin_allocation_country_code` varchar(4) DEFAULT NULL,
  `origin_allocation_province_code` varchar(4) DEFAULT NULL,
  `origin_allocation_name` varchar(150) DEFAULT NULL,
  `origin_allocation_address1` varchar(250) DEFAULT NULL,
  `origin_allocation_address2` varchar(250) DEFAULT NULL,
  `origin_allocation_city` varchar(100) DEFAULT NULL,
  `origin_allocation_zip` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_line_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for order_line_item_property
-- ----------------------------
DROP TABLE IF EXISTS `order_line_item_property`;
CREATE TABLE `order_line_item_property` (
  `id` int(11) NOT NULL,
  `order_item_id` bigint(20) DEFAULT NULL,
  `_name` varchar(150) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_item_id` (`order_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for order_note_attribute
-- ----------------------------
DROP TABLE IF EXISTS `order_note_attribute`;
CREATE TABLE `order_note_attribute` (
  `id` int(11) NOT NULL,
  `order_id` bigint(11) DEFAULT NULL,
  `_name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `shipping_address_id` int(11) DEFAULT NULL,
  `billing_address_id` int(11) DEFAULT NULL,
  `customer_id` bigint(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `note` text,
  `token` varchar(50) DEFAULT NULL,
  `gateway` varchar(50) DEFAULT NULL,
  `test` varchar(50) DEFAULT NULL,
  `total_price` decimal(19,4) DEFAULT NULL,
  `subtotal_price` decimal(19,4) DEFAULT NULL,
  `total_weight` decimal(19,4) DEFAULT NULL,
  `total_tax` decimal(19,4) DEFAULT NULL,
  `taxes_included` varchar(50) DEFAULT NULL,
  `currency` varchar(50) DEFAULT NULL,
  `financial_status` varchar(50) DEFAULT NULL,
  `confirmed` varchar(50) DEFAULT NULL,
  `total_discounts` decimal(19,4) DEFAULT NULL,
  `total_line_items_price` decimal(19,4) DEFAULT NULL,
  `cart_token` varchar(50) DEFAULT NULL,
  `buyer_accepts_marketing` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `referring_site` varchar(500) DEFAULT NULL,
  `landing_site` varchar(500) DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `cancel_reason` varchar(150) DEFAULT NULL,
  `total_price_usd` decimal(19,4) DEFAULT NULL,
  `checkout_token` varchar(50) DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `location_id` varchar(50) DEFAULT NULL,
  `source_identifier` varchar(50) DEFAULT NULL,
  `source_url` varchar(50) DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL,
  `device_id` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `customer_locale` varchar(50) DEFAULT NULL,
  `app_id` varchar(50) DEFAULT NULL,
  `browser_ip` varchar(50) DEFAULT NULL,
  `landing_site_ref` varchar(50) DEFAULT NULL,
  `order_number` int(11) DEFAULT NULL,
  `discount_applications_type` varchar(50) DEFAULT NULL,
  `discount_applications_value` varchar(50) DEFAULT NULL,
  `discount_applications_value_type` varchar(50) DEFAULT NULL,
  `discount_applications_allocation_method` varchar(50) DEFAULT NULL,
  `discount_applications_target_selection` varchar(50) DEFAULT NULL,
  `discount_applications_target_type` varchar(50) DEFAULT NULL,
  `discount_applications_code` varchar(50) DEFAULT NULL,
  `discount_codes_code` varchar(50) DEFAULT NULL,
  `discount_codes_amount` varchar(50) DEFAULT NULL,
  `discount_codes_type` varchar(50) DEFAULT NULL,
  `payment_gateway_names` varchar(50) DEFAULT NULL COMMENT 'array',
  `processing_method` varchar(50) DEFAULT NULL,
  `checkout_id` varchar(50) DEFAULT NULL,
  `source_name` varchar(50) DEFAULT NULL,
  `fulfillment_status` varchar(50) DEFAULT NULL,
  `discount_allocations` varchar(255) DEFAULT NULL,
  `tax_lines_price` varchar(50) DEFAULT NULL,
  `tax_lines_rate` varchar(50) DEFAULT NULL,
  `tax_lines_title` varchar(50) DEFAULT NULL,
  `tags` varchar(150) DEFAULT NULL,
  `contact_email` varchar(250) DEFAULT NULL,
  `order_status_url` text,
  `total_tip_received` decimal(19,4) DEFAULT NULL,
  `admin_graphql_api_id` varchar(100) DEFAULT NULL,
  `shipping_lines_id` bigint(20) DEFAULT NULL,
  `shipping_lines_title` varchar(255) DEFAULT NULL,
  `shipping_lines_price` decimal(19,4) DEFAULT NULL,
  `shipping_lines_code` varchar(150) DEFAULT NULL,
  `shipping_lines_source` varchar(150) DEFAULT NULL,
  `shipping_lines_phone` varchar(20) DEFAULT NULL,
  `shipping_lines_requested_fulfillment_service_id` varchar(150) DEFAULT NULL,
  `shipping_lines_delivery_category` varchar(50) DEFAULT NULL,
  `shipping_lines_carrier_identifier` varchar(50) DEFAULT NULL,
  `shipping_lines_discounted_price` decimal(19,4) DEFAULT NULL,
  `shipping_lines_discount_allocations` varchar(255) DEFAULT NULL COMMENT 'array',
  `shipping_lines_tax_lines_title` varchar(100) DEFAULT NULL,
  `shipping_lines_tax_lines_price` decimal(19,4) DEFAULT NULL,
  `shipping_lines_rate` decimal(19,4) DEFAULT NULL,
  `fulfillments` varchar(255) DEFAULT NULL COMMENT 'array',
  `order_client_detail_browser_ip` varchar(15) DEFAULT NULL,
  `order_client_detail_accept_language` varchar(50) DEFAULT NULL,
  `order_client_detail_user_agent` varchar(255) DEFAULT NULL,
  `order_client_detail_session_hash` varchar(100) DEFAULT NULL,
  `order_client_detail_browser_width` int(11) DEFAULT NULL,
  `order_client_detail_browser_height` int(11) DEFAULT NULL,
  `refunds` varchar(255) DEFAULT NULL COMMENT 'array',
  `payment_details_credit_card_bin` varchar(30) DEFAULT NULL,
  `payment_details_avs_result_code` varchar(10) DEFAULT NULL,
  `payment_details_cvv_result_code` varchar(10) DEFAULT NULL,
  `payment_details_credit_card_number` varchar(30) DEFAULT NULL,
  `payment_details_credit_card_company` varchar(20) DEFAULT NULL,
  `json_body` longtext,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `shipping_address_id` (`shipping_address_id`),
  KEY `billing_address_id` (`billing_address_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for shipment
-- ----------------------------
DROP TABLE IF EXISTS `shipment`;
CREATE TABLE `shipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_number` varchar(50) DEFAULT NULL COMMENT 'A PRO number is a series of numbers used by carriers as a reference for freight movement. The term “PRO number” is short for progressive number. This series of numbers is used as a tracking tool. PRO numbers are usually 7 to 10 digits long.',
  `uom` varchar(30) DEFAULT NULL COMMENT 'UOM - Unit of Measure. It stands for Unit of Measure. UOM are used to quantify the inventory items and enables to track them. It''s a physical unit (like kg, dozen, meter etc.) in which we measure and manage different items.',
  `supplier_address_id` int(11) DEFAULT NULL,
  `customer_address_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `supplier_address_id` (`supplier_address_id`),
  KEY `customer_address_id` (`customer_address_id`),
  CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`supplier_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `shipment_ibfk_2` FOREIGN KEY (`customer_address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for user_table
-- ----------------------------
DROP TABLE IF EXISTS `user_table`;
CREATE TABLE `user_table` (
  `pd_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `tableName` varchar(50) NOT NULL,
  PRIMARY KEY (`pd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Procedure structure for get_invoice
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_invoice`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `get_invoice`(_invoice_id INT)
get_invoice:BEGIN

DECLARE cba VARCHAR(500);
DECLARE csa VARCHAR(500);
DECLARE sba VARCHAR(500);

/*
SET pro = (
	SELECT
		json_object('',mega.shipment.pro_number)
	FROM
		mega._invoice
		INNER JOIN mega.shipment ON mega.shipment.id = mega._invoice.shipment_id
	WHERE
		mega._invoice.id = _invoice_id
);
*/
SET cba = (
	SELECT
		group_concat(
			json_object (
				'company_name',
				IFNULL(mega.business_entity.legal_name,''),
				'address1',
				mega.address.address1,
				'address2',
				mega.address.address2,
				'city',
				mega.address.city,
				'province_code',
				mega.address.province_code,
				'zip',
				mega.address.zip,
				'country',
				UPPER(mega.address.country),
				'attn',
				CONCAT('Attn:',mega.address.first_name,' ',mega.address.last_name)
			)
		)
	FROM
		mega._invoice
		INNER JOIN mega.shipment ON mega.shipment.id = mega._invoice.shipment_id
		INNER JOIN mega.address ON mega.address.id = mega.shipment.customer_address_id
		LEFT JOIN mega.business_entity ON mega.business_entity.id = mega.address.business_entity_id
		WHERE
			mega._invoice.id = _invoice_id
);

if cba is null then select 'customer_billing_address is empty. cannot generate invoice'; end if;

SET csa = (
	SELECT
		group_concat(
			json_object (
				'company_name',
				IFNULL(mega.business_entity.legal_name,''),
				'address1',
				mega.address.address1,
				'address2',
				mega.address.address2,
				'city',
				mega.address.city,
				'province_code',
				mega.address.province_code,
				'zip',
				mega.address.zip,
				'country',
				UPPER(mega.address.country),
				'attn',
				CONCAT('Attn:',mega.address.first_name,' ',mega.address.last_name)
			)
		)
	FROM
		mega._invoice
		INNER JOIN mega.shipment ON mega.shipment.id = mega._invoice.shipment_id
		INNER JOIN mega.address ON mega.address.id = mega.shipment.customer_address_id
		LEFT JOIN mega.business_entity ON mega.business_entity.id = mega.address.business_entity_id
		WHERE
			mega._invoice.id = _invoice_id

);

if csa is null then select 'customer_shipping_address is empty. cannot generate invoice'; end if;

SET sba = (
	SELECT
		group_concat(
			json_object (
				'company_name',
				IFNULL(mega.business_entity.legal_name,''),
				'address1',
				mega.address.address1,
				'address2',
				mega.address.address2,
				'city',
				mega.address.city,
				'province_code',
				mega.address.province_code,
				'zip',
				mega.address.zip,
				'country',
				UPPER(mega.address.country),
				'attn',
				CONCAT('Attn:',mega.address.first_name,' ',mega.address.last_name)
			)
		)
	FROM
		mega._invoice
		INNER JOIN mega.shipment ON mega.shipment.id = mega._invoice.shipment_id
		INNER JOIN mega.address ON mega.address.id = mega.shipment.supplier_address_id
		LEFT JOIN mega.business_entity ON mega.business_entity.id = mega.address.business_entity_id
		WHERE
			mega._invoice.id = _invoice_id
);

if sba is null then select 'supplier_billing_address is empty. cannot generate invoice'; end if;



SELECT json_pretty(
	concat(
		"{",
		'\"billing_address": ' ,cba,
		',',
		'\"shipping_address\": ',csa,
		',',
		'\"vendor\": ',sba,
		"}"
	)) as invoice;



END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for reset_data
-- ----------------------------
DROP PROCEDURE IF EXISTS `reset_data`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `reset_data`()
BEGIN

set foreign_key_checks = 0;

TRUNCATE mega.address;
TRUNCATE mega.customer;
TRUNCATE mega.order_line_item;
TRUNCATE mega.order_note_attribute;
TRUNCATE mega.orders;

set foreign_key_checks = 1;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_customer
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_customer`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `save_customer`(_id bigint(20), _order_id BIGINT, _email varchar(255), _accepts_marketing varchar(10), _created_at varchar(50), _updated_at varchar(50), _first_name varchar(50), _last_name varchar(50), _state varchar(20), _note text, _verified_email varchar(10), _multipass_identifier varchar(50), _tax_exempt varchar(10), _phone varchar(20), _tags varchar(150), _admin_graphql_api_id varchar(100), _default_address_id bigint(20), _default_address_first_name varchar(50), _default_address_last_name varchar(50), _default_address_company varchar(50), _default_address_address1 varchar(150), _default_address_address2 varchar(150), _default_address_city varchar(50), _default_address_province varchar(30), _default_address_country varchar(30), _default_address_zip varchar(10), _default_address_phone varchar(20), _default_address_province_code varchar(10), _default_address_country_code varchar(10), _default_address_country_name varchar(30))
BEGIN


INSERT IGNORE INTO mega.customer (
	id,
	email,
	accepts_marketing,
	created_at,
	updated_at,
	first_name,
	last_name,
	state,
	note,
	verified_email,
	multipass_identifier,
	tax_exempt,
	phone,
	tags,
	admin_graphql_api_id,
	default_address_id,
	default_address_first_name,
	default_address_last_name,
	default_address_company,
	default_address_address1,
	default_address_address2,
	default_address_city,
	default_address_province,
	default_address_country,
	default_address_zip,
	default_address_phone,
	default_address_province_code,
	default_address_country_code,
	default_address_country_name
)
VALUES
	(
		_id,
		_email,
		_accepts_marketing,
		REPLACE(REPLACE(_created_at,'T',' '),'-06:00',''),
		REPLACE(REPLACE(_updated_at,'T',' '),'-06:00',''),
		_first_name,
		_last_name,
		_state,
		_note,
		_verified_email,
		_multipass_identifier,
		_tax_exempt,
		_phone,
		_tags,
		_admin_graphql_api_id,
		_default_address_id,
		_default_address_first_name,
		_default_address_last_name,
		_default_address_company,
		_default_address_address1,
		_default_address_address2,
		_default_address_city,
		_default_address_province,
		_default_address_country,
		_default_address_zip,
		_default_address_phone,
		_default_address_province_code,
		_default_address_country_code,
		_default_address_country_name
	);

if _order_id IS NOT NULL then update mega.orders set customer_id = _id where id = _order_id; end if;


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_order
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_order`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `save_order`(_id bigint(20), _email varchar(255), _closed_at varchar(50), _created_at varchar(50), _updated_at varchar(50), _number int(11), _note text, _token varchar(50), _gateway varchar(50), _test varchar(50), _total_price decimal(19,4), _subtotal_price decimal(19,4), _total_weight decimal(19,4), _total_tax decimal(19,4), _taxes_included varchar(50), _currency varchar(50), _financial_status varchar(50), _confirmed varchar(50), _total_discounts decimal(19,4), _total_line_items_price decimal(19,4), _cart_token varchar(50), _buyer_accepts_marketing varchar(50), _name varchar(50), _referring_site varchar(500), _landing_site varchar(500), _cancelled_at varchar(50), _cancel_reason varchar(150), _total_price_usd decimal(19,4), _checkout_token varchar(50), _reference varchar(50), _user_id varchar(50), _location_id varchar(50), _source_identifier varchar(50), _source_url varchar(50), _processed_at varchar(50), _device_id varchar(50), _phone varchar(50), _customer_locale varchar(50), _app_id varchar(50), _browser_ip varchar(50), _landing_site_ref varchar(50), _order_number int(11), _discount_applications_type varchar(50), _discount_applications_value varchar(50), _discount_applications_value_type varchar(50), _discount_applications_allocation_method varchar(50), _discount_applications_target_selection varchar(50), _discount_applications_target_type varchar(50), _discount_applications_code varchar(50), _discount_codes_code varchar(50), _discount_codes_amount varchar(50), _discount_codes_type varchar(50), _payment_gateway_names varchar(50), _processing_method varchar(50), _checkout_id varchar(50), _source_name varchar(50), _fulfillment_status varchar(50), _tax_lines_price varchar(50), _tax_lines_rate varchar(50), _tax_lines_title varchar(50), _tags varchar(150), _contact_email varchar(250), _order_status_url text, _admin_graphql_api_id varchar(100), _json_body TEXT)
BEGIN


INSERT IGNORE INTO mega.orders (
	id,
	email,
	closed_at,
	created_at,
	updated_at,
	number,
	note,
	token,
	gateway,
	test,
	total_price,
	subtotal_price,
	total_weight,
	total_tax,
	taxes_included,
	currency,
	financial_status,
	confirmed,
	total_discounts,
	total_line_items_price,
	cart_token,
	buyer_accepts_marketing,
	`name`,
	referring_site,
	landing_site,
	cancelled_at,
	cancel_reason,
	total_price_usd,
	checkout_token,
	reference,
	user_id,
	location_id,
	source_identifier,
	source_url,
	processed_at,
	device_id,
	phone,
	customer_locale,
	app_id,
	browser_ip,
	landing_site_ref,
	order_number,
	discount_applications_type,
	discount_applications_value,
	discount_applications_value_type,
	discount_applications_allocation_method,
	discount_applications_target_selection,
	discount_applications_target_type,
	discount_applications_code,
	discount_codes_code,
	discount_codes_amount,
	discount_codes_type,
	payment_gateway_names,
	processing_method,
	checkout_id,
	source_name,
	fulfillment_status,
	tax_lines_price,
	tax_lines_rate,
	tax_lines_title,
	tags,
	contact_email,
	order_status_url,
	admin_graphql_api_id,
	json_body
) VALUES (
	_id,
	_email,
	REPLACE(REPLACE(_closed_at,'T',' '),'-06:00',''),
	REPLACE(REPLACE(_created_at,'T',' '),'-06:00',''),
	REPLACE(REPLACE(_updated_at,'T',' '),'-06:00',''),
	_number,
	_note,
	_token,
	_gateway,
	_test,
	_total_price,
	_subtotal_price,
	_total_weight,
	_total_tax,
	_taxes_included,
	_currency,
	_financial_status,
	_confirmed,
	_total_discounts,
	_total_line_items_price,
	_cart_token,
	_buyer_accepts_marketing,
	_name,
	_referring_site,
	_landing_site,
	REPLACE(REPLACE(_cancelled_at,'T',' '),'-06:00',''),
	_cancel_reason,
	_total_price_usd,
	_checkout_token,
	_reference,
	_user_id,
	_location_id,
	_source_identifier,
	_source_url,
	REPLACE(REPLACE(_processed_at,'T',' '),'-06:00',''),
	_device_id,
	_phone,
	_customer_locale,
	_app_id,
	_browser_ip,
	_landing_site_ref,
	_order_number,
	_discount_applications_type,
	_discount_applications_value,
	_discount_applications_value_type,
	_discount_applications_allocation_method,
	_discount_applications_target_selection,
	_discount_applications_target_type,
	_discount_applications_code,
	_discount_codes_code,
	_discount_codes_amount,
	_discount_codes_type,
	_payment_gateway_names,
	_processing_method,
	_checkout_id,
	_source_name,
	_fulfillment_status,
	_tax_lines_price,
	_tax_lines_rate,
	_tax_lines_title,
	_tags,
	_contact_email,
	_order_status_url,
	_admin_graphql_api_id,
	_json_body
	);


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_order_address
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_order_address`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `save_order_address`(_order_id bigint, _address_type varchar(30), _shopify_address_id bigint(20), _first_name varchar(50), _last_name varchar(50), _company varchar(50), _address1 varchar(150), _address2 varchar(150), _city varchar(50), _zip varchar(10), _province varchar(30), _province_code varchar(10), _country varchar(30), _country_code varchar(10), _phone varchar(20), _latitude FLOAT, _longitude FLOAT)
BEGIN

DECLARE _address_id INT;

set _address_id = (
select id from mega.address 
where 
	first_name		=	IFNULL(_first_name,'') AND
	last_name			=	IFNULL(_last_name,'') AND
	company				=	IFNULL(_company,'') AND
	address1			=	IFNULL(_address1,'') AND
	address2			=	IFNULL(_address2,'') AND
	city					=	IFNULL(_city,'') AND
	zip						=	IFNULL(_zip,'') AND
	province			=	IFNULL(_province,'') AND
	province_code	=	IFNULL(_province_code,'') AND
	country				=	IFNULL(_country,'') AND
	country_code	=	IFNULL(_country_code,'') /*AND
	phone					=	_phone AND
	latitude			=	_latitude AND
	longitude			=	_longitude */
);


if _address_id is null then


	INSERT IGNORE INTO mega.address (
		shopify_address_id,
		is_billing,
		is_shipping,
		first_name,
		last_name,
		company,
		address1,
		address2,
		city,
		zip,
		province,
		province_code,
		country,
		country_code,
		phone,
		latitude,
		longitude
	)
	VALUES
		(
		_shopify_address_id,
		IF(_address_type = 'billing',1,0),
		IF(_address_type = 'shipping',1,0),
		_first_name,
		_last_name,
		_company,
		_address1,
		_address2,
		_city,
		_zip,
		_province,
		_province_code,
		_country,
		_country_code,
		_phone,
		round(_latitude,8),
		round(_longitude,8)
		);

	set _address_id = LAST_INSERT_ID();


end if;

if _address_type = 'shipping' then update mega.orders set shipping_address_id = _address_id where id = _order_id; end if;
if _address_type = 'billing' then update mega.orders set billing_address_id = _address_id where id = _order_id; end if;

if _address_type = 'billing' then update mega.address set is_billing = 1 where id = _address_id; end if;
if _address_type = 'shipping' then update mega.address set is_shipping = 1 where id = _address_id; end if;


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_order_line_item
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_order_line_item`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `save_order_line_item`(_id bigint(20),_order_id bigint(20),_variant_id bigint(20),_title varchar(255),_quantity int(11),_price decimal(19,4),_sku varchar(50),_variant_title varchar(50),_vendor varchar(50),_fulfillment_service varchar(50),_product_id bigint(20),_requires_shipping varchar(50),_taxable varchar(50),_gift_card varchar(50),_pname varchar(150),_variant_inventory_management varchar(50),_product_exists varchar(255),_fulfillable_quantity int(11),_grams int(11),_total_discount decimal(19,4),_fulfillment_status varchar(50),_discount_allocations varchar(255),_admin_graphql_api_id varchar(100),_tax_lines_title varchar(50),_tax_lines_price decimal(19,4),_tax_lines_rate decimal(19,4),_origin_allocation_id bigint(20),_origin_allocation_country_code varchar(4),_origin_allocation_province_code varchar(4),_origin_allocation_name varchar(150),_origin_allocation_address1 varchar(250),_origin_allocation_address2 varchar(250),_origin_allocation_city varchar(100),_origin_allocation_zip varchar(10))
BEGIN

		INSERT IGNORE INTO mega.order_line_item (
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
			_name,
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
			origin_allocation_zip
		)
		VALUES
			(
				_id,
				_order_id,
				_variant_id,
				_title,
				_quantity,
				_price,
				_sku,
				_variant_title,
				_vendor,
				_fulfillment_service,
				_product_id,
				_requires_shipping,
				_taxable,
				_gift_card,
				_pname,
				_variant_inventory_management,
				_product_exists,
				_fulfillable_quantity,
				_grams,
				_total_discount,
				_fulfillment_status,
				_discount_allocations,
				_admin_graphql_api_id,
				_tax_lines_title,
				_tax_lines_price,
				_tax_lines_rate,
				_origin_allocation_id,
				_origin_allocation_country_code,
				_origin_allocation_province_code,
				_origin_allocation_name,
				_origin_allocation_address1,
				_origin_allocation_address2,
				_origin_allocation_city,
				_origin_allocation_zip
			);
-- select * from mega.order_line_item;
COMMIT;
/*
SELECT
				_id,
				_order_id,
				_variant_id,
				_title,
				_quantity,
				_price,
				_sku,
				_variant_title,
				_vendor,
				_fulfillment_service,
				_product_id,
				_requires_shipping,
				_taxable,
				_gift_card,
				_pname,
				_variant_inventory_management,
				_product_exists,
				_fulfillable_quantity,
				_grams,
				_total_discount,
				_fulfillment_status,
				_discount_allocations,
				_admin_graphql_api_id,
				_tax_lines_title,
				_tax_lines_price,
				_tax_lines_rate,
				_origin_allocation_id,
				_origin_allocation_country_code,
				_origin_allocation_province_code,
				_origin_allocation_name,
				_origin_allocation_address1,
				_origin_allocation_address2,
				_origin_allocation_city,
				_origin_allocation_zip;*/



END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_order_line_item_property
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_order_line_item_property`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `save_order_line_item_property`()
BEGIN
	#Routine body goes here...

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_order_note_attribute
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_order_note_attribute`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `save_order_note_attribute`(_id bigint, _email varchar(255), _closed_at timestamp, _created_at timestamp, _updated_at timestamp, _number int(11), _note text, _token varchar(50), _gateway varchar(50), _test varchar(50), _total_price decimal(19,4), _subtotal_price decimal(19,4), _total_weight decimal(19,4), _total_tax decimal(19,4), _taxes_included varchar(50), _currency varchar(50), _financial_status varchar(50), _confirmed varchar(50), _total_discounts decimal(19,4), _total_line_items_price decimal(19,4), _cart_token varchar(50), _buyer_accepts_marketing varchar(50), _name varchar(50), _referring_site varchar(500), _landing_site varchar(500), _cancelled_at timestamp, _cancel_reason varchar(150), _total_price_usd decimal(19,4), _checkout_token varchar(50), _reference varchar(50), _user_id varchar(50), _location_id varchar(50), _source_identifier varchar(50), _source_url varchar(50), _processed_at timestamp, _device_id varchar(50), _phone varchar(50), _customer_locale varchar(50), _app_id varchar(50), _browser_ip varchar(50), _landing_site_ref varchar(50), _order_number int(11), _discount_applications_type varchar(50), _discount_applications_value varchar(50), _discount_applications_value_type varchar(50), _discount_applications_allocation_method varchar(50), _discount_applications_target_selection varchar(50), _discount_applications_target_type varchar(50), _discount_applications_code varchar(50), _discount_codes_code varchar(50), _discount_codes_amount varchar(50), _discount_codes_type varchar(50), _payment_gateway_names varchar(50), _processing_method varchar(50), _checkout_id varchar(50), _source_name varchar(50), _fulfillment_status varchar(50), _tax_lines_price varchar(50), _tax_lines_rate varchar(50), _tax_lines_title varchar(50), _tags varchar(50), _contact_email varchar(50), _order_status_url text, _admin_graphql_api_id varchar(100))
BEGIN


INSERT INTO mega.orders (
	id,
	email,
	closed_at,
	created_at,
	updated_at,
	number,
	note,
	token,
	gateway,
	test,
	total_price,
	subtotal_price,
	total_weight,
	total_tax,
	taxes_included,
	currency,
	financial_status,
	confirmed,
	total_discounts,
	total_line_items_price,
	cart_token,
	buyer_accepts_marketing,
	`name`,
	referring_site,
	landing_site,
	cancelled_at,
	cancel_reason,
	total_price_usd,
	checkout_token,
	reference,
	user_id,
	location_id,
	source_identifier,
	source_url,
	processed_at,
	device_id,
	phone,
	customer_locale,
	app_id,
	browser_ip,
	landing_site_ref,
	order_number,
	discount_applications_type,
	discount_applications_value,
	discount_applications_value_type,
	discount_applications_allocation_method,
	discount_applications_target_selection,
	discount_applications_target_type,
	discount_applications_code,
	discount_codes_code,
	discount_codes_amount,
	discount_codes_type,
	payment_gateway_names,
	processing_method,
	checkout_id,
	source_name,
	fulfillment_status,
	tax_lines_price,
	tax_lines_rate,
	tax_lines_title,
	tags,
	contact_email,
	order_status_url,
	admin_graphql_api_id
) VALUES (
	_id,
	_email,
	_closed_at,
	_created_at,
	_updated_at,
	_number,
	_note,
	_token,
	_gateway,
	_test,
	_total_price,
	_subtotal_price,
	_total_weight,
	_total_tax,
	_taxes_included,
	_currency,
	_financial_status,
	_confirmed,
	_total_discounts,
	_total_line_items_price,
	_cart_token,
	_buyer_accepts_marketing,
	_name,
	_referring_site,
	_landing_site,
	_cancelled_at,
	_cancel_reason,
	_total_price_usd,
	_checkout_token,
	_reference,
	_user_id,
	_location_id,
	_source_identifier,
	_source_url,
	_processed_at,
	_device_id,
	_phone,
	_customer_locale,
	_app_id,
	_browser_ip,
	_landing_site_ref,
	_order_number,
	_discount_applications_type,
	_discount_applications_value,
	_discount_applications_value_type,
	_discount_applications_allocation_method,
	_discount_applications_target_selection,
	_discount_applications_target_type,
	_discount_applications_code,
	_discount_codes_code,
	_discount_codes_amount,
	_discount_codes_type,
	_payment_gateway_names,
	_processing_method,
	_checkout_id,
	_source_name,
	_fulfillment_status,
	_tax_lines_price,
	_tax_lines_rate,
	_tax_lines_title,
	_tags,
	_contact_email,
	_order_status_url,
	_admin_graphql_api_id
	);


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for save_order_shipping_line
-- ----------------------------
DROP PROCEDURE IF EXISTS `save_order_shipping_line`;
DELIMITER ;;
CREATE DEFINER=`remote`@`%` PROCEDURE `save_order_shipping_line`()
BEGIN
	#Routine body goes here...

END
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
