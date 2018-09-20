//
//  DetailHeaderCell.swift
//  RCA
//
//  Created by Ashok Gupta on 20/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class DetailHeaderCell: BaseTableViewCell {

    @IBOutlet weak var lblLoungeAccess: UILabel!
    @IBOutlet weak var stackLoungeAccess: UIStackView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblChildPrice: UILabel!
    @IBOutlet weak var lblChild: UILabel!
    @IBOutlet weak var lblAdultPrice: UILabel!
    @IBOutlet weak var lblAdult: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(productData: MnA_ProductData, serviceData: ServiceData, formData: FormData) {
        
        stackLoungeAccess.isHidden = serviceData.product_id == "2" ? true : false
        lblLoungeAccess.text = "Upto \(productData.max_no_of_hrs ?? "0") hours"
        
            lblProduct.text = productData.product_id == "3" ? productData.product_name! + " by " + productData.supplier! : productData.product_name
            
            if let type = formData.travelType {
                
                var strDesc: String = ""
                
                switch type {
                    
                case .Arrival:
                    strDesc = "\(productData.airport!), Terminal -  \(productData.arrival_terminal!), \(productData.city!), \(String(describing: productData.country!))"
                    
                case .Departure:
                    strDesc = "\(productData.airport!), Terminal -  \(productData.departure_terminal!), \(productData.city!), \(String(describing: productData.country!))"
                    
                case .Transit:
                    strDesc = "\(productData.airport!), \(productData.city!), \(String(describing: productData.country!))"
                }
                lblDesc.text = strDesc
            }
            
            if productData.rate_application == RateType.Person.rawValue {
                
                lblAdult.isHidden = false
                lblAdultPrice.isHidden = false
                
                lblAdult.text = "Adult Price:"
                lblChild.text = "Child Price:"
                
                if productData.child_free != "" {
                    if let max: Int = formData.childAge.max() , let freeAge = productData.child_free {
                        
                        if let freeAge = Int(freeAge) {
                            
                            if freeAge <= max {
                                
                                lblChild.isHidden = false
                                lblChildPrice.isHidden = false
                            }
                            else {
                                lblChild.isHidden = true
                                lblChildPrice.isHidden = true
                            }
                        }
                    }
                }
                else {
                    lblChild.isHidden = false
                    lblChildPrice.isHidden = false
                }
                
                if productData.c_total_sp_usd_with_gst == "" || productData.c_total_sp_usd_with_gst == "0" {
                    lblChild.isHidden = true
                    lblChildPrice.isHidden = true
                }
                
                lblAdultPrice.text =  Utils.dollarSymbol + (productData.total_sp_usd_with_gst?.roundOff)!
                lblChildPrice.text = Utils.dollarSymbol + ( productData.c_total_sp_usd_with_gst?.roundOff)!
            }
            else if productData.rate_application == RateType.Group.rawValue {
                
                lblAdult.isHidden = false
                lblChild.isHidden = true
                lblAdultPrice.isHidden = false
                lblChildPrice.isHidden = true
                
                lblAdult.text = "Group Price:"
                lblAdultPrice.text =  Utils.dollarSymbol + (productData.total_sp_usd_with_gst?.roundOff)!
            }
        
    }

}
