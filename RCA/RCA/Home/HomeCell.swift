//
//  HomeCell.swift
//  RCA
//
//  Created by TWC on 02/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class HomeCell: BaseTableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        baseView.layer.cornerRadius = 7.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(_ data: Any?) {
        
//        if let data = data as? Service {
//            
//            lblTitle.text = data.title
//            lblDesc.text = data.description
//            imgLogo.image = data.image
//        }
//        else if let data = data as? E_Visa {
//            
//            lblTitle.text = data.title
//            lblDesc.text = data.description
//            imgLogo.image = data.image
//        }
    }

}
