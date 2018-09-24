//
//  PageViewContentVC.swift
//  RCA
//
//  Created by Ashok Gupta on 16/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol PageViewContentVCDelegate:class {
    func goNext()
}

class VoicePageViewContentVC: UIViewController {
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var txtAnswer: UITextField!
    weak var delegate:PageViewContentVCDelegate?
    
    var pageIndex: Int = 0
    
    private var data:QuestionData?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
       // txtAnswer.text = ""
        txtAnswer.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(data:QuestionData){
        print(data)
        self.data = data
        lblQuestion.text = data.question
        
        if let value = data.answer {
            txtAnswer.text = value
        }
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        
    }
}

extension VoicePageViewContentVC :UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        data?.answer = textField.text
        delegate?.goNext()
        
        return false
    }
}
