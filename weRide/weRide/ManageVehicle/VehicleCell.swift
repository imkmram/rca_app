//
//  VehicleCell.swift
//  weRide
//
//  Created by Ashok Gupta on 04/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class VehicleCell: BaseTableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblMileage: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblRegNo: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       baseView.layer.cornerRadius = 10.0
    }
    
    override func setData(_ data: Any?) {
        
        if let data = data as? Result_set {
            lblRegNo.text = data.registration_no
            
            let make = data.manufacturer ?? ""
            let color = data.color ?? ""
            lblModel.text = make + " " + color
            
            if data.vehicle_type == "Car" {
                imgView.image = #imageLiteral(resourceName: "vehicle")
            }
            else if data.vehicle_type == "Bike" {
                imgView.image = #imageLiteral(resourceName: "bike")
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
