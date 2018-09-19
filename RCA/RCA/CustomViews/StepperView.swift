//
//  StepperView.swift
//  RCA
//
//  Created by Ashok Gupta on 15/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol StepperViewDelegate: class {
    func changedValue(stepper: StepperView, value: Int)
}

class StepperView: UIView {
    
 var isIncrementTapped = false
    var isDecrementTappaed = false
    
  private var intValue:Int = 0
    var maxValue : Int = 20
    weak var delegate: StepperViewDelegate?
    
    var value: Int {
        get {
            return intValue
        }
        set {
            intValue = newValue
        }
    }

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btnDecrement: UIButton!
    @IBOutlet weak var btnIncrement: UIButton!
    
    override func awakeFromNib() {
        
        btnIncrement.showsTouchWhenHighlighted = false
        btnDecrement.showsTouchWhenHighlighted = false
        btnIncrement.setBackgroundColor(UIColor.gray, for: .highlighted)
        btnDecrement.setBackgroundColor(UIColor.gray, for: .highlighted)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 7.0
        stackView.layer.cornerRadius = 7.0
     
        if #available(iOS 11.0, *) {
            btnDecrement.layer.cornerRadius = 6.0
            btnDecrement.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]

            btnIncrement.layer.cornerRadius = 6.0
            btnIncrement.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]

        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func btnIncrementTapped(_ sender: UIButton) {
        
        isIncrementTapped = true
        isDecrementTappaed = false
        
        if intValue < maxValue {
        intValue = intValue + 1
        print(intValue)
        delegate?.changedValue(stepper: self, value: value)
        }
    }
    
    @IBAction func btnDecrementTapped(_ sender: UIButton) {
        
         isDecrementTappaed = true
        isIncrementTapped = false
       
        if intValue > 0 && intValue <= maxValue {
            intValue = intValue - 1
            print(intValue)
            delegate?.changedValue(stepper: self, value: value)
        }
    }
}
