//
//  AgeCell.swift
//  RCA
//
//  Created by Ashok Gupta on 18/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol AgeCellDelegate: class {
    func updateAge(age:Int, row: Int)
}

class AgeCell: BaseTableViewCell {
    
    weak var delegate: AgeCellDelegate?
    
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stepperContentView: UIView!
    var stepperView: StepperView?

    override func awakeFromNib() {
        
        super.awakeFromNib()
        stepperView = StepperView.loadNib()
        self.stepperView?.frame = CGRect(x: 0, y: 0, width: stepperContentView.bounds.size.width, height: stepperContentView.bounds.size.height)
        stepperView?.maxValue = 18
        stepperView?.delegate = self
        stepperContentView.addSubview(stepperView!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(_ data: Any?) {
        
        if let data = data as? Int {
            lblTitle.text = "Child - \(self.tag + 1)"
            txtAge.text = String(data)
        }
    }
}

extension AgeCell : StepperViewDelegate {
    func changedValue(stepper: StepperView, value: Int) {
        txtAge.text = String(value)
        delegate?.updateAge(age: value, row:self.tag )
    }
}
