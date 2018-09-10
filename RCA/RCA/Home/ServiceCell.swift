//
//  ServiceCell.swift
//  RCA
//
//  Created by Ashok Gupta on 05/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class ServiceCell: BaseCollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        baseView.layer.cornerRadius = 8.0
    }
    
    func setData(data: Service_list?) {
        
        if let result = data {
            
            lblTitle.text = result.title
            img.image = #imageLiteral(resourceName: "e_visa")
        }
    }
}
