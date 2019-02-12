//
//  EmergencyCell.swift
//  weRide
//
//  Created by Ashok Gupta on 04/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class EmergencyCell: BaseTableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblContactNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.layer.cornerRadius = 8.0
    }
    
    override func setData(_ data: Any?) {
        
        if let data = data as? Result_set {
            lblName.text = data.contact_name
            lblContactNumber.text = data.contact_no
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
