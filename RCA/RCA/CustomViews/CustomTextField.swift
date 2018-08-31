//
//  CustomTextField.swift
//  RCA
//
//  Created by Ashok Gupta on 20/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol CustomFieldDelegate:class {
    func btnEnterTapped(value:String)
}

class CustomTextField: UIView {
    
    weak var delegate:CustomFieldDelegate?
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var txtField: UITextField!
    var data: QuestionData?

    func setKeyboardType() {
        
        guard let data = data else {
            return
        }
        switch data.questionID {
        case 3, 4:
            txtField.keyboardType = .numberPad
        case 2:
            txtField.keyboardType = .numbersAndPunctuation
        default:
            txtField.keyboardType = .alphabet
        }
    }
    
    @IBAction func btnEnterTapped(_ sender: Any) {
        
        delegate?.btnEnterTapped(value: txtField.text ?? "")
    }
}
