//
//  LoungeFormCell.swift
//  RCA
//
//  Created by Ashok Gupta on 14/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol LoungeFormCellDelegate: class {
    
    func btnCalenderTapped(sender: UIButton);
    func btnCalendarPopOverTapped(sender: UIButton)
    func updateCount(stepperView: StepperView, count: String)
}

class LoungeFormCell: BaseTableViewCell {
    
    @IBOutlet private weak var childStepperViewContent: UIView!
    @IBOutlet private weak var adultStepperViewContent: UIView!
    @IBOutlet private weak var txtTravelData: UITextField!
    @IBOutlet private weak var btnCal: UIButton!
    @IBOutlet private weak var txtChildCount: UITextField!
    @IBOutlet private weak var txtAdultCount: UITextField!
    
    weak var delegate: LoungeFormCellDelegate?
    
    var adultCountView: StepperView?
    var childCountView: StepperView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        adultCountView = StepperView.loadNib()
        adultCountView?.tag = 0
        adultCountView?.delegate = self
        self.adultCountView?.frame = CGRect(x: 0, y: 0, width: adultStepperViewContent.bounds.size.width, height: adultStepperViewContent.bounds.size.height)
        adultStepperViewContent.addSubview(adultCountView!)
        
        childCountView = StepperView.loadNib()
        childCountView?.tag = 1
        childCountView?.delegate = self
        self.childCountView?.frame = CGRect(x: 0, y: 0, width: childStepperViewContent.bounds.size.width, height: childStepperViewContent.bounds.size.height)
        childStepperViewContent.addSubview(childCountView!)
    }
    
    override func setData(_ data: Any?) {
        
        if let formData = data as? FormData {
            txtTravelData.text = formData.travelDate
            txtAdultCount.text = String(formData.adultCount)
            txtChildCount.text = String(formData.childCount)
            adultCountView?.value = formData.adultCount
            childCountView?.value = formData.childCount
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCalPopOverTapped(_ sender: Any) {
        delegate?.btnCalendarPopOverTapped(sender: sender as! UIButton)
    }
    
    @IBAction func btnCalTapped(_ sender: Any) {
        
        delegate?.btnCalenderTapped(sender: sender as! UIButton)
    }
}

extension LoungeFormCell : StepperViewDelegate {
    
    func changedValue(stepper: StepperView, value: Int) {
        delegate?.updateCount(stepperView: stepper, count: String(value))
    }
}
