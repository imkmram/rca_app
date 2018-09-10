//
//  ModalVC.swift
//  RCA
//
//  Created by Ashok Gupta on 20/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol ModalVCDelegate: class {
    func removeOverlay()
    func updateInputValue(value:String)
     func continueTappped()
}

class ModalVC: UIViewController {
    
    @IBOutlet weak var btnClose: UIButton!
    weak var delegate: ModalVCDelegate?
//    var controlPosition:CGPoint?
    var data:QuestionData?

    var isIndianVisaSelected:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isIndianVisaSelected  {
            
            let vc = Utils.getMainStoryboardController(identifier: Constant.HOMEPOPUP_VC) as! HomePopup
            
            vc.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            vc.view.backgroundColor = UIColor.clear
            vc.delegate = self
            vc.view.clipsToBounds = true
            self.addChildViewController(vc)
            view.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
        else {
            
            let vc = Utils.getE_visaStoryboardController(identifier: Constant.ANSWER_VC) as! AnswerVC
            
            vc.data = data
            vc.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            vc.view.backgroundColor = UIColor.clear
            self.addChildViewController(vc)
            view.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
        self.view.bringSubview(toFront: btnClose)
    }
    
    override func viewWillLayoutSubviews() {
    }
    
//    override func viewDidLayoutSubviews() {
//        self.view.backgroundColor = UIColor.clear
//        if !isAnimated {
//            addSubviewWithZoomInAnimation(customField!, duration: 0.5)
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func addSubviewWithZoomInAnimation(_ view: UIView, duration: TimeInterval) {
        
//        view.transform = view.transform.scaledBy(x: 0.01, y: 0.01)
//        self.view.addSubview(view)
//
//        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
//            view.transform = CGAffineTransform.identity
//        }) { (success) in
//            if success {
//                 self.customField?.setKeyboardType()
//                self.customField?.txtField.becomeFirstResponder()
//                self.isAnimated = true
//            }
//        }
//    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        delegate?.removeOverlay()
    }
}

extension ModalVC : CustomFieldDelegate {
    func btnEnterTapped(value: String) {
        
//        delegate?.updateInputValue(value: value)
//        dismiss(animated: true, completion: nil)
//        delegate?.removeOverlay()
    }
}

extension ModalVC : HomePopupDelegate {
    func btnContinueTapped() {
    
        delegate?.continueTappped()
    }
}
