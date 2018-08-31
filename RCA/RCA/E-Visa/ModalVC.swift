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
}

class ModalVC: UIViewController {
    
    weak var delegate: ModalVCDelegate?
    var controlPosition:CGPoint?
    var data:QuestionData?
    var customField:CustomTextField?
    var isAnimated:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customField = Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)?.first as? CustomTextField
        customField?.frame.origin = CGPoint(x:20, y: data?.rect?.origin.y ?? 0)
        customField?.frame.size = CGSize(width:view.frame.size.width - 20 - 10, height: 60)
        customField?.delegate = self
        if let data = data {
            customField?.data = data
        }
        
        print(CFGetRetainCount(data))
    }
    
    override func viewWillLayoutSubviews() {
    }
    
    override func viewDidLayoutSubviews() {
        self.view.backgroundColor = UIColor.clear
        if !isAnimated {
         addSubviewWithZoomInAnimation(customField!, duration: 0.5)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSubviewWithZoomInAnimation(_ view: UIView, duration: TimeInterval) {
        
        view.transform = view.transform.scaledBy(x: 0.01, y: 0.01)
        self.view.addSubview(view)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            view.transform = CGAffineTransform.identity
        }) { (success) in
            if success {
                 self.customField?.setKeyboardType()
                self.customField?.txtField.becomeFirstResponder()
                self.isAnimated = true
            }
        }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        delegate?.removeOverlay()
    }
}

extension ModalVC : CustomFieldDelegate {
    func btnEnterTapped(value: String) {
        
        delegate?.updateInputValue(value: value)
        dismiss(animated: true, completion: nil)
        delegate?.removeOverlay()
    }
}
