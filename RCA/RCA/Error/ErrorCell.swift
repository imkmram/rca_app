//
//  ErrorCell.swift
//  RCA
//
//  Created by Ashok Gupta on 28/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class ErrorCell: BaseTableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(_ data: Any?) {
        if data == nil {
            lblMessage.text = message
        }
    }

}
