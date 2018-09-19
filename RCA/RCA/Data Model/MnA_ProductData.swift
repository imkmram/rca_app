/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct MnA_ProductData : Codable {
    
//    let p_id : String?
//    let sr_no : String?
	let nationality : String?
	let product_id : String?
	let product_category : String?
	let product_type : String?
	let product_name : String?
	let service_id : String?
	let serviced_by : String?
	let inclusions : String?
	let service_description : String?
//    let visa_entry : String?
//    let visa_validity : String?
//    let visa_duration : String?
    let min_no_of_hrs : String?
    let max_no_of_hrs : String?
	let airport : String?
	let airport_code : String?
	let arrival_terminal : String?
	let departure_terminal : String?
	let travel_type : String?
	let city : String?
	let country : String?
	let country_code : String?
	let supplier : String?
//    let supplier_status : String?
	let rate_application : String?
	let currency : String?
//    let adult_cost_price : String?
//    let adult_cost_tax : String?
//    let child_cost_price : String?
//    let child_cost_tax : String?
//    let child_defination_max : String?
//    let child_defination_min : String?
    let child_free : String?
//    let group_size_min : String?
//    let group_size_max : String?
//    let group_price : String?
//    let group_price_tax : String?
//    let exceptions : String?
//    let booking_cut_off : String?
//    let time_zone : String?
//    let service_charge_adult : String?
//    let total : String?
//    let service_tax_adult : String?
//    let service_charge_child : String?
//    let service_tax_child : String?
//    let service_tax_applicable_on : String?
//    let sales_cut_off : String?
//    let sales_cut_off_time_zone : String?
//    let cancellation_time : String?
//    let cancellation_charges : String?
//    let discount : String?
//    let discount_amount : String?
//    let output_price : String?
//    let important_notes : String?
//    let booking_type : String?
//    let gst_criteria : String?
//    let gst_base_amount : String?
//    let gst_rate : String?
//    let gst_rate_currency : String?
//	let total_sp : String?
//    let total_sp_with_gst : String?
//    let total_sp_usd : String?
	let total_sp_usd_with_gst : String?
//    let total_sp_inr : String?
//    let total_sp_inr_with_gst : String?
//    let c_total_sp : String?
//	let c_total_sp_with_gst : String?
//	let c_total_sp_usd : String?
	let c_total_sp_usd_with_gst : String?
//    let c_total_sp_inr : String?
//    let c_total_sp_inr_with_gst : String?
	let buffet_meals : String?
	let alcoholic_beverages : String?
	let non_alcoholic_beverages : String?
	let wifi : String?
	let shower : String?
	let smoking_zone : String?
	let prayer_room : String?
	let sleeping_pods : String?
	let kids_play_area : String?
	let fast_track_immigration : String?
	let fast_track_security : String?
	let porter : String?
	let personal_assistance : String?
	let lounge : String?
	let child_free_2yrs : String?
	let child_free_3yrs : String?
	let child_free_5yrs : String?
	let child_free_6yrs : String?
//	let is_active : String?
	let supplier_product : String?

	enum CodingKeys: String, CodingKey {

//        case p_id = "p_id"
//        case sr_no = "sr_no"
		case nationality = "nationality"
		case product_id = "product_id"
		case product_category = "product_category"
		case product_type = "product_type"
		case product_name = "product_name"
		case service_id = "service_id"
		case serviced_by = "serviced_by"
		case inclusions = "inclusions"
		case service_description = "service_description"
//        case visa_entry = "visa_entry"
//        case visa_validity = "visa_validity"
//        case visa_duration = "visa_duration"
		case min_no_of_hrs = "min_no_of_hrs"
		case max_no_of_hrs = "max_no_of_hrs"
		case airport = "airport"
		case airport_code = "airport_code"
		case arrival_terminal = "arrival_terminal"
		case departure_terminal = "departure_terminal"
		case travel_type = "travel_type"
		case city = "city"
		case country = "country"
		case country_code = "country_code"
		case supplier = "supplier"
//		case supplier_status = "supplier_status"
		case rate_application = "rate_application"
		case currency = "currency"
//        case adult_cost_price = "adult_cost_price"
//        case adult_cost_tax = "adult_cost_tax"
//        case child_cost_price = "child_cost_price"
//        case child_cost_tax = "child_cost_tax"
//        case child_defination_max = "child_defination_max"
//        case child_defination_min = "child_defination_min"
        case child_free = "child_free"
//        case group_size_min = "group_size_min"
//        case group_size_max = "group_size_max"
//        case group_price = "group_price"
//        case group_price_tax = "group_price_tax"
//        case exceptions = "exceptions"
//        case booking_cut_off = "booking_cut_off"
//        case time_zone = "time_zone"
//        case service_charge_adult = "service_charge_adult"
//        case total = "total"
//        case service_tax_adult = "service_tax_adult"
//        case service_charge_child = "service_charge_child"
//        case service_tax_child = "service_tax_child"
//        case service_tax_applicable_on = "service_tax_applicable_on"
//        case sales_cut_off = "sales_cut_off"
//        case sales_cut_off_time_zone = "sales_cut_off_time_zone"
//        case cancellation_time = "cancellation_time"
//        case cancellation_charges = "cancellation_charges"
//        case discount = "discount"
//        case discount_amount = "discount_amount"
//        case output_price = "output_price"
//        case important_notes = "important_notes"
//        case booking_type = "booking_type"
//        case gst_criteria = "gst_criteria"
//        case gst_base_amount = "gst_base_amount"
//        case gst_rate = "gst_rate"
//        case gst_rate_currency = "gst_rate_currency"
//        case total_sp = "total_sp"
//        case total_sp_with_gst = "total_sp_with_gst"
//        case total_sp_usd = "total_sp_usd"
		case total_sp_usd_with_gst = "total_sp_usd_with_gst"
//        case total_sp_inr = "total_sp_inr"
//        case total_sp_inr_with_gst = "total_sp_inr_with_gst"
//        case c_total_sp = "c_total_sp"
//        case c_total_sp_with_gst = "c_total_sp_with_gst"
//        case c_total_sp_usd = "c_total_sp_usd"
		case c_total_sp_usd_with_gst = "c_total_sp_usd_with_gst"
//        case c_total_sp_inr = "c_total_sp_inr"
//        case c_total_sp_inr_with_gst = "c_total_sp_inr_with_gst"
		case buffet_meals = "buffet_meals"
		case alcoholic_beverages = "alcoholic_beverages"
		case non_alcoholic_beverages = "non_alcoholic_beverages"
		case wifi = "wifi"
		case shower = "shower"
		case smoking_zone = "smoking_zone"
		case prayer_room = "prayer_room"
		case sleeping_pods = "sleeping_pods"
		case kids_play_area = "kids_play_area"
		case fast_track_immigration = "fast_track_immigration"
		case fast_track_security = "fast_track_security"
		case porter = "porter"
		case personal_assistance = "personal_assistance"
		case lounge = "lounge"
		case child_free_2yrs = "child_free_2yrs"
		case child_free_3yrs = "child_free_3yrs"
		case child_free_5yrs = "child_free_5yrs"
		case child_free_6yrs = "child_free_6yrs"
//		case is_active = "is_active"
		case supplier_product = "supplier_product"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
//		p_id = try values.decodeIfPresent(String.self, forKey: .p_id)
//		sr_no = try values.decodeIfPresent(String.self, forKey: .sr_no)
		nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
		product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
		product_category = try values.decodeIfPresent(String.self, forKey: .product_category)
		product_type = try values.decodeIfPresent(String.self, forKey: .product_type)
		product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
		service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
		serviced_by = try values.decodeIfPresent(String.self, forKey: .serviced_by)
		inclusions = try values.decodeIfPresent(String.self, forKey: .inclusions)
		service_description = try values.decodeIfPresent(String.self, forKey: .service_description)
//        visa_entry = try values.decodeIfPresent(String.self, forKey: .visa_entry)
//        visa_validity = try values.decodeIfPresent(String.self, forKey: .visa_validity)
//        visa_duration = try values.decodeIfPresent(String.self, forKey: .visa_duration)
		min_no_of_hrs = try values.decodeIfPresent(String.self, forKey: .min_no_of_hrs)
		max_no_of_hrs = try values.decodeIfPresent(String.self, forKey: .max_no_of_hrs)
		airport = try values.decodeIfPresent(String.self, forKey: .airport)
		airport_code = try values.decodeIfPresent(String.self, forKey: .airport_code)
		arrival_terminal = try values.decodeIfPresent(String.self, forKey: .arrival_terminal)
		departure_terminal = try values.decodeIfPresent(String.self, forKey: .departure_terminal)
		travel_type = try values.decodeIfPresent(String.self, forKey: .travel_type)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
		supplier = try values.decodeIfPresent(String.self, forKey: .supplier)
//        supplier_status = try values.decodeIfPresent(String.self, forKey: .supplier_status)
		rate_application = try values.decodeIfPresent(String.self, forKey: .rate_application)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
//        adult_cost_price = try values.decodeIfPresent(String.self, forKey: .adult_cost_price)
//        adult_cost_tax = try values.decodeIfPresent(String.self, forKey: .adult_cost_tax)
//        child_cost_price = try values.decodeIfPresent(String.self, forKey: .child_cost_price)
//        child_cost_tax = try values.decodeIfPresent(String.self, forKey: .child_cost_tax)
//        child_defination_max = try values.decodeIfPresent(String.self, forKey: .child_defination_max)
//        child_defination_min = try values.decodeIfPresent(String.self, forKey: .child_defination_min)
        child_free = try values.decodeIfPresent(String.self, forKey: .child_free)
//        group_size_min = try values.decodeIfPresent(String.self, forKey: .group_size_min)
//        group_size_max = try values.decodeIfPresent(String.self, forKey: .group_size_max)
//        group_price = try values.decodeIfPresent(String.self, forKey: .group_price)
//        group_price_tax = try values.decodeIfPresent(String.self, forKey: .group_price_tax)
//        exceptions = try values.decodeIfPresent(String.self, forKey: .exceptions)
//        booking_cut_off = try values.decodeIfPresent(String.self, forKey: .booking_cut_off)
//        time_zone = try values.decodeIfPresent(String.self, forKey: .time_zone)
//        service_charge_adult = try values.decodeIfPresent(String.self, forKey: .service_charge_adult)
//        total = try values.decodeIfPresent(String.self, forKey: .total)
//        service_tax_adult = try values.decodeIfPresent(String.self, forKey: .service_tax_adult)
//        service_charge_child = try values.decodeIfPresent(String.self, forKey: .service_charge_child)
//        service_tax_child = try values.decodeIfPresent(String.self, forKey: .service_tax_child)
//        service_tax_applicable_on = try values.decodeIfPresent(String.self, forKey: .service_tax_applicable_on)
//        sales_cut_off = try values.decodeIfPresent(String.self, forKey: .sales_cut_off)
//        sales_cut_off_time_zone = try values.decodeIfPresent(String.self, forKey: .sales_cut_off_time_zone)
//        cancellation_time = try values.decodeIfPresent(String.self, forKey: .cancellation_time)
//        cancellation_charges = try values.decodeIfPresent(String.self, forKey: .cancellation_charges)
//        discount = try values.decodeIfPresent(String.self, forKey: .discount)
//        discount_amount = try values.decodeIfPresent(String.self, forKey: .discount_amount)
//        output_price = try values.decodeIfPresent(String.self, forKey: .output_price)
//        important_notes = try values.decodeIfPresent(String.self, forKey: .important_notes)
//        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
//        gst_criteria = try values.decodeIfPresent(String.self, forKey: .gst_criteria)
//        gst_base_amount = try values.decodeIfPresent(String.self, forKey: .gst_base_amount)
//        gst_rate = try values.decodeIfPresent(String.self, forKey: .gst_rate)
//        gst_rate_currency = try values.decodeIfPresent(String.self, forKey: .gst_rate_currency)
//        total_sp = try values.decodeIfPresent(String.self, forKey: .total_sp)
//        total_sp_with_gst = try values.decodeIfPresent(String.self, forKey: .total_sp_with_gst)
//        total_sp_usd = try values.decodeIfPresent(String.self, forKey: .total_sp_usd)
		total_sp_usd_with_gst = try values.decodeIfPresent(String.self, forKey: .total_sp_usd_with_gst)
//        total_sp_inr = try values.decodeIfPresent(String.self, forKey: .total_sp_inr)
//        total_sp_inr_with_gst = try values.decodeIfPresent(String.self, forKey: .total_sp_inr_with_gst)
//        c_total_sp = try values.decodeIfPresent(String.self, forKey: .c_total_sp)
//        c_total_sp_with_gst = try values.decodeIfPresent(String.self, forKey: .c_total_sp_with_gst)
//        c_total_sp_usd = try values.decodeIfPresent(String.self, forKey: .c_total_sp_usd)
		c_total_sp_usd_with_gst = try values.decodeIfPresent(String.self, forKey: .c_total_sp_usd_with_gst)
//        c_total_sp_inr = try values.decodeIfPresent(String.self, forKey: .c_total_sp_inr)
//        c_total_sp_inr_with_gst = try values.decodeIfPresent(String.self, forKey: .c_total_sp_inr_with_gst)
		buffet_meals = try values.decodeIfPresent(String.self, forKey: .buffet_meals)
		alcoholic_beverages = try values.decodeIfPresent(String.self, forKey: .alcoholic_beverages)
		non_alcoholic_beverages = try values.decodeIfPresent(String.self, forKey: .non_alcoholic_beverages)
		wifi = try values.decodeIfPresent(String.self, forKey: .wifi)
		shower = try values.decodeIfPresent(String.self, forKey: .shower)
		smoking_zone = try values.decodeIfPresent(String.self, forKey: .smoking_zone)
		prayer_room = try values.decodeIfPresent(String.self, forKey: .prayer_room)
		sleeping_pods = try values.decodeIfPresent(String.self, forKey: .sleeping_pods)
		kids_play_area = try values.decodeIfPresent(String.self, forKey: .kids_play_area)
		fast_track_immigration = try values.decodeIfPresent(String.self, forKey: .fast_track_immigration)
		fast_track_security = try values.decodeIfPresent(String.self, forKey: .fast_track_security)
		porter = try values.decodeIfPresent(String.self, forKey: .porter)
		personal_assistance = try values.decodeIfPresent(String.self, forKey: .personal_assistance)
		lounge = try values.decodeIfPresent(String.self, forKey: .lounge)
		child_free_2yrs = try values.decodeIfPresent(String.self, forKey: .child_free_2yrs)
		child_free_3yrs = try values.decodeIfPresent(String.self, forKey: .child_free_3yrs)
		child_free_5yrs = try values.decodeIfPresent(String.self, forKey: .child_free_5yrs)
		child_free_6yrs = try values.decodeIfPresent(String.self, forKey: .child_free_6yrs)
//      is_active = try values.decodeIfPresent(String.self, forKey: .is_active)
		supplier_product = try values.decodeIfPresent(String.self, forKey: .supplier_product)
	}

}
