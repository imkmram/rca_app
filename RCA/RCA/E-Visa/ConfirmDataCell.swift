//
//  ConfirmDataCell.swift
//  RCA
//
//  Created by TWC on 07/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol ConfirmDataCellDelegate:class {
    func btnConfirmTapped(sender:UIButton)
}

class ConfirmDataCell: BaseTableViewCell {

    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var stackBaseView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPassengers: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblVisaType: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    weak var delegate: ConfirmDataCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BGView.layer.cornerRadius = 8.0
        stackBaseView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func setData(_ data: Any?) {
        
        if let data:ConfirmData = data as? ConfirmData {
            
            lblName.attributedText = data.attributedName
            lblPassengers.attributedText = data.pax
            lblDate.attributedText = data.travellingDate
            lblVisaType.attributedText = data.visaType
            lblEmail.attributedText = data.email
            lblPhone.attributedText = data.phone
        }
    }
    
    @IBAction func btnConfirmTapped(_ sender: UIButton) {
        delegate?.btnConfirmTapped(sender: sender)
    }
}
