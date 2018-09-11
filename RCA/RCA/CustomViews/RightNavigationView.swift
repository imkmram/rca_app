//
//  RightNavigationView.swift
//  RCA
//
//  Created by Ashok Gupta on 11/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class RightNavigationView: UIView {
    
    //static let shared = RightNavigationView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
}
