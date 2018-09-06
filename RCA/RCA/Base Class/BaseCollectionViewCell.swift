//
//  BaseCollectionViewCell.swift
//  RCA
//
//  Created by Ashok Gupta on 06/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    class var identifier: String { return String.className(self) }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    open override func awakeFromNib() {
    }
    
    open func setup() {
    }
    
}
