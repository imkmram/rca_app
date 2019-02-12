//
//  InsuranceCell.swift
//  weRide
//
//  Created by Ashok Gupta on 11/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class InsuranceCell: BaseTableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var txtInsurer: UITextField!
    @IBOutlet weak var txtInsuredAmt: UITextField!
    @IBOutlet weak var txtExpiry: UITextField!
    
    //MARK:- Member Variable
    var data: VehicleModel!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtInsurer.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
        txtInsuredAmt.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
        txtExpiry.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
    }
    
    //MARK:- Binding Data
    override func setData(_ data: Any?) {
        
        if let model = data as? VehicleModel {
            
            self.data = model
            txtInsurer.text = model.insurer
            txtExpiry.text = model.expiryDate
            txtInsuredAmt.text = model.insuredAmt
        }
    }
    
    //MARK:- Event
    @objc func textChanged(sender: UITextField) {
        
        switch sender.tag {
        case 0:
            data.insurer = sender.text
        case 1:
            data.expiryDate = sender.text
        case 2:
            data.insuredAmt = sender.text
        default:
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
