//
//  RoundedView.swift
//  weRide
//
//  Created by Ashok Gupta on 11/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.height * 0.02
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
