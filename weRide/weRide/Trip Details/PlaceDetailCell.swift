//
//  PlaceDetailCell.swift
//  weRide
//
//  Created by Ashok Gupta on 22/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class PlaceDetailCell: BaseTableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var baseView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
