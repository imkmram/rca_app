//
//  ManualVC.swift
//  RCA
//
//  Created by Ashok Gupta on 11/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import ReverseExtension

class ManualVC: UIViewController {

    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet weak var bottomBaseView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtInput: UITextView!
    
    private var questionnaireList: [Questionnaire] = [Questionnaire]()
    private var rowCount: Int = 1
    private var questionIndex: Int = 0
    
    private var passengerName:String?
    var country:E_Visa = E_Visa()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblChat.registerCellNib(ChatCell.self)
        tblChat.rowHeight = UITableViewAutomaticDimension
        tblChat.estimatedRowHeight = 160
        
        txtInput.delegate = self
        tblChat.re.delegate = self
        tblChat.re.dataSource = self
        
        tblChat.re.scrollViewDidReachTop = { scrollView in
            print("scrollViewDidReachTop")
            //self.tblChat.contentOffset = CGPoint(x: 0.0, y: 0.0)
        }
        tblChat.re.scrollViewDidReachBottom = { scrollView in
            print("scrollViewDidReachBottom")
            //self.tblChat.contentOffset = CGPoint(x: 0.0, y: 0.0)
        }
        
        //btnProceed.isHidden = true
        //btnNext.isHidden = false
        
        questionnaireList = [Questionnaire(questionID:1, question: "Hey friend, how do I address you as?", answerFramed:"Your name is {{value}}."),
                             Questionnaire(questionID:2, question: "So,\(String(describing: passengerName ?? "What")) is your last name?", answerFramed:"Your last name is {{value}}."),
                             Questionnaire(questionID:3, question: "I am happy you are flying high. What is your passport number?", answerFramed:"Your passport number is {{value}}"),
                             Questionnaire(questionID:4, question: "I don’t mean to intrude, but how many of you’ll are travelling?.", answerFramed:"Number of traveller is {{value}}"),
                             Questionnaire(questionID:5, question: "Are you going for Business or as a tourist or transiting?.", answerFramed:"You want {{value}}"),
                             Questionnaire(questionID:6, question: "That sounds interesting. When do you arrive in Malaysia?.", answerFramed:"Your arrival at \(String(describing: "\(country.title ?? "")")) {{value}}"),
                             Questionnaire(questionID:7, question: "How many days are you planning to stay?", answerFramed:"You plan to stay for {{value}}"),
                             Questionnaire(questionID:8, question: "That’s great! Let’s get connected. What is your email id?", answerFramed:"Your email address is {{value}}"),
                             Questionnaire(questionID:9, question: "Thanks. Where can i contact you? Your phone number please…", answerFramed:"Your phone number is {{value}}")
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bottomBaseView.layer.cornerRadius = 8;
        txtInput.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btnNextTapped(_ sender: Any) {
        
        let validate = Validate()
        
        UIView.animate(withDuration: 0.0, animations: {
            
           
            
            let result = validate.validate(value: self.txtInput.text, questionID: self.questionnaireList[self.questionIndex].questionID)
//                self.questionnaireList[self.questionIndex].answer =   validate.validate(value: self.txtInput.text, questionID: self.questionnaireList[self.questionIndex].questionID)
            
            self.questionnaireList[self.questionIndex].answer = result.0
             self.questionnaireList[self.questionIndex].isValid = result.1
            
                self.txtInput.text = ""
         self.tblChat.beginUpdates()
            self.tblChat.reloadData()
            
            self.tblChat.endUpdates()
            
        }) { (success) in
            
            if success {
            
                UIView.animate(withDuration: 0.70, animations: {
                    self.tblChat.beginUpdates()
                    self.questionIndex =  self.questionIndex + 1
                    self.rowCount = self.rowCount + 1
                    self.tblChat.re.insertRows(at: [IndexPath(row: self.rowCount - 1, section: 0)], with: .none)
                    self.tblChat.endUpdates()
                })
            }
        }
    }
}

extension ManualVC : UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
    }
}

extension ManualVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier) as! ChatCell
        
        //cell.delegate = self
       // cell.btnEdit.tag = indexPath.row
        cell.btnEdit.isHidden = true
        
        cell.setData(questionnaireList[indexPath.row])
        
        return cell
    }
}

extension ManualVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView.contentOffset.y =", scrollView.contentOffset.y)
        scrollView.contentOffset = CGPoint(x: 0.0, y: 0.0)
    }
}
