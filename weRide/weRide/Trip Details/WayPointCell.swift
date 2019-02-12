//
//  WayPointCell.swift
//  weRide
//
//  Created by Ashok Gupta on 27/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

protocol WayPointCellDelegate: class {
    func btnDeleteTapped(sender: UIButton)
    func btnCellTapped(sender: UIButton)
}

class WayPointCell: BaseTableViewCell {
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSrNo: UILabel!
    
    @IBOutlet weak var btnCell: UIButton!
    weak var delegate: WayPointCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.layer.cornerRadius = 5.0
    }

    @IBAction func btnCellTapped(_ sender: UIButton) {
        delegate?.btnCellTapped(sender: sender)
    }
    @IBAction func btnDeleteTapped(_ sender: UIButton) {
        delegate?.btnDeleteTapped(sender: sender)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
