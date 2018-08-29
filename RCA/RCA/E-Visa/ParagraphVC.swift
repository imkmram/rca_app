//
//  ParagraphVC.swift
//  RCA
//
//  Created by Ashok Gupta on 20/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class ParagraphVC: UIViewController{

    @IBOutlet weak var txtView: UITextView!
    var selectedQuestionID: Int?
    
   private let questions:[QuestionData] = [
            QuestionData(questionID: 1, question: "[Your Name]", identifier: "yourname"),
            QuestionData(questionID: 2, question: "[Travel Date]", identifier: "traveldate"),
            QuestionData(questionID: 3, question: "[Adults Count]", identifier: "adultscount"),
            QuestionData(questionID: 4, question: "[Children Count]", identifier: "childcount")
        ]
  
    var attributedString:NSMutableAttributedString = NSMutableAttributedString(string: "I, am [Your Name] travelling to Malaysia on [Travel Date] with [Adults Count] adults and [Children Count] children")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeAttributedString()
        txtView.attributedText = attributedString
        txtView.isEditable = false
        txtView.isSelectable = true
        txtView.delegate = self
        
        let linkTextAttributes:[String:Any] = [
            NSAttributedStringKey.underlineStyle.rawValue: 0,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.red,
            NSAttributedStringKey.font.rawValue: UIFont(name: "OpenSans-SemiBold", size: 25) as Any
        ]
        txtView.linkTextAttributes = linkTextAttributes
    }
    
    func initializeAttributedString() {
        
        attributedString.setAttributes([NSAttributedStringKey.font : UIFont(name: "OpenSans-Regular", size: 20) as Any, NSAttributedStringKey.foregroundColor:UIColor.black], range: NSRange(location: 0, length: attributedString.length))
        
        for question in questions {
            
            if question.answer == nil {
                
                let range = attributedString.mutableString.range(of: question.question!, options: .caseInsensitive)
                
                question.range = range
                
                let attributes = [NSAttributedStringKey.font : UIFont(name: "OpenSans-Regular", size: 25) as Any, NSAttributedStringKey.foregroundColor:UIColor.lightGray, NSAttributedStringKey.link:question.tapIdentifier!]
                
                attributedString.setAttributes(attributes, range: range)
            }
            else {
                if question.questionID != selectedQuestionID {
                    let range = attributedString.mutableString.range(of: question.answer!, options: .forcedOrdering)

                    question.range = range
                }
                let attributes = [NSAttributedStringKey.font : UIFont(name: "OpenSans-Light", size: 25) as Any, NSAttributedStringKey.link:question.tapIdentifier!]
                
                attributedString.setAttributes(attributes, range: question.range!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadOverlay(data:QuestionData) {
        
        print(CFGetRetainCount(data))
        
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        blurredBackgroundView.alpha = 0.5
        view.addSubview(blurredBackgroundView)
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
        let modalVC = storyboard.instantiateViewController(withIdentifier: "ModalVC") as! ModalVC
        modalVC.modalPresentationStyle = .overCurrentContext
        modalVC.delegate = self
       // modalVC.controlPosition = CGPoint(x: rect.origin.x, y: rect.origin.y + txtView.frame.origin.y + rect.size.height)
        modalVC.data = data
        self.present(modalVC, animated: true, completion: nil)
    }
}

 // MARK: - ModalVCDelegate
extension ParagraphVC : ModalVCDelegate {
    
    func updateInputValue(value: String) {
        
        if  value.length == 0 {
            return
        }
        
        let fetchedQuestion = questions.filter { (data:QuestionData) -> Bool in
            
            if data.questionID == selectedQuestionID {
                return true
            }
            else {
                return false
            }
        }
        
        if fetchedQuestion.count > 0 {
            
            if let question = fetchedQuestion.first {
                
                print(CFGetRetainCount(question))
                
                question.answer = "[" + value + "]"
                
                attributedString.replaceCharacters(in:question.range! , with: question.answer!)
                question.range = NSRange(location: (question.range?.location)!, length: question.answer!.length)
                
                initializeAttributedString()
                
                self.txtView.attributedText = attributedString
                
                txtView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.red, NSAttributedStringKey.font.rawValue: UIFont(name: "OpenSans-SemiBold", size: 25) as Any]
            }
        }
    }
    
    func removeOverlay() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension ParagraphVC : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        let fetchedQuestion = questions.filter { (data:QuestionData) -> Bool in
            
            if URL.description == data.tapIdentifier {
                return true
            }
            else {
                return false
            }
        }
        
        if fetchedQuestion.count > 0 {
            
            if let question = fetchedQuestion.first {
                
                selectedQuestionID = question.questionID
                
                txtView.layoutManager.ensureLayout(for: textView.textContainer)
                let start = txtView.position(from: txtView.beginningOfDocument, offset: (question.range!.location))!
                let end = txtView.position(from: start, offset: (question.range?.length)!)!
                let tRange = txtView.textRange(from: start, to: end)
                let rect =  txtView.firstRect(for: tRange!)
                
                let newRect:CGRect = CGRect(x: rect.origin.y, y: rect.origin.y + txtView.frame.origin.y + rect.size.height , width: rect.size.width, height: rect.size.height)
                question.rect = newRect
                
                self.loadOverlay(data: question)
            }
        }
            return false
    }
}
