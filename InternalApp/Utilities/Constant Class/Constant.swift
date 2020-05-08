//
//  Constant.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 27/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

// URLs
//OLD APIs
/*
let BASE_URL = "https://apidev.eotor.net/api/"


// APIs NAME

let k_API_GET_ACCESS_TOKEN = "auth/token"*/
//let k_API_GET_INVENTORY_DATA = "product.product"
//let k_API_POST_CHANGE_PASSWORD = "change.password.wizard"
let k_API_PATCH_CHANGE_PASSWORD = "change.password.wizard/"
let k_API_GET_MODULES = "ir.module.module"
//let k_API_GET_USER_DETAILS = "res.partner/"
let k_API_GET_MAINTENACE_DETAILS = "maintenance.request" //upar wala 5  
let k_API_GET_EQUIPMENT_DETAILS = "maintenance.equipment" // neeche wala 13

// NEW APIs
// BASE URL
let BASE_URL = "https://13.eotor.net/apis/"

// APIs NAME

// TOKEN
let k_API_GET_ACCESS_TOKEN = "get_token"
let k_API_POST_REVOKE_TOKEN = "revoke_token"

// USER
let k_API_GET_USER_DETAILS = "userinfo"

// SALE
let k_API_GET_CURRENT_SALE = "current_sale"
let k_API_GET_OUT_OF_STOCK = "out_of_stock"
let k_API_GET_TOTAL_SALE = "total_sale"

// SETTING
let k_API_POST_CHANGE_PASSWORD = "setting_change_password"
let k_API_POST_CHANGE_LANGUAGE = "setting_change_languages"

// HR
let k_API_GET_ALL_EMPLOYEE = "get_employee"
let k_API_GET_EMPLOYEE_INFO = "get_employee_info"
let k_API_POST_EDIT_EMPLOYEE_INFO = "change_employee_info"
let k_API_GET_LEAVE_TYPE = "get_leave_type_list"
let k_API_POST_LEAVE_REQUEST = "post_leave_req"
let k_API_GET_LEAVE_LIST = "leave_list"
let k_API_GET_INVENTORY_DATA = "inventory_check"
let k_API_GET_SUPPLIERS_AND_PRODUCTS = "get_suppliers_and_products"










// MESSAGEs

let msg_PLEASE_WAIT = "Please Wait..."

let BAD_CODE = "400"

