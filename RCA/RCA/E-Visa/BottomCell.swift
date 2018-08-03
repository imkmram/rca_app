//
//  BottomCell.swift
//  RCA
//
//  Created by TWC on 03/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol BottomCellDelegate:class {
    
    func btnVoiceTapped(sender:UIButton)
    func btnManualTapped(sender:UIButton)
}

class BottomCell: BaseTableViewCell {

    @IBOutlet weak var btnManual: RoundButton!
    @IBOutlet weak var btnVoice: RoundButton!
    @IBOutlet weak var baseView: UIView!
    
    weak var delegate :BottomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        baseView.layer.cornerRadius = 7.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnVoiceTapped(_ sender: UIButton) {
        delegate?.btnVoiceTapped(sender: sender)
    }
    
    @IBAction func btnManualTapped(_ sender: UIButton) {
        delegate?.btnManualTapped(sender: sender)
    }
}
