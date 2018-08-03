//
//  ContinueButton.swift
//  RCA
//
//  Created by TWC on 03/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    @IBInspectable var borderWidth :CGFloat = 0 {
        didSet {
           refreshBorderWidth(value: borderWidth)
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.white {
        didSet {
            refreshBorderColor(value: borderColor)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
        refreshBorderWidth(value: borderWidth)
        refreshBorderColor(value: borderColor)
    }
    
    func refreshCorners(value:CGFloat) {
        layer.cornerRadius = value
    }
    func refreshBorderWidth(value:CGFloat) {
        layer.borderWidth = value
    }
    func refreshBorderColor(value:UIColor) {
        layer.borderColor = value.cgColor
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
