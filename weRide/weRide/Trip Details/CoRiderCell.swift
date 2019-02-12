//
//  CoRiderCell.swift
//  weRide
//
//  Created by Ashok Gupta on 01/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class CoRiderCell: BaseTableViewCell {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(_ data: Any?) {
        
        if let rider = data as? Participants {
            lblName.text = rider.name
            lblMobile.text = rider.mobileno
            lblEmail.text = rider.email_id
        }
    }

}
