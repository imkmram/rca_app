//
//  NewVoiceVC.swift
//  RCA
//
//  Created by Ashok Gupta on 23/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import Speech
import SDWebImage

class NewVoiceVC: UIViewController {

    @IBOutlet weak var bottomBaseView: UIView!
    @IBOutlet weak var tblChats: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblCapturedText: UILabel!
    @IBOutlet weak var btnProceed: RoundButton!
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    var questionnaireList: [Questionnaire] = [Questionnaire]()
    var rowCount: Int = 1
    var questionIndex: Int = 0
    var isNavigated: Bool = false
    
    var country:E_Visa = E_Visa()
    
    var passengerName:String?
    
    var rowSelected:Int?
    
    var isValidatingAnswer:Bool = false
    var repeatQuestion: Bool = false
    
    var tempCapturedValue: String = ""
    
    lazy var speechController = SpeechController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblChats.registerCellNib(ChatCell.self)
        tblChats.rowHeight = UITableViewAutomaticDimension
        tblChats.estimatedRowHeight = 160
        
        btnProceed.isHidden = true
        btnNext.isHidden = false
        
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
        
        
        speechSynthesizer.delegate = self
        speechController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // bottomBaseView.layer.cornerRadius = bottomBaseView.frame.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !isNavigated {
            askQuestion(index: questionIndex)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        speechController.delegate = nil
//        speechController.stopRecording()
    }
    
    func askQuestion(index:Int) {
        
        if questionIndex < questionnaireList.count {
            tblChats.reloadData()
            tblChats.scrollToRow(at: IndexPath(row: questionIndex, section: 0), at: .top, animated: true)
            let speechUtterance = AVSpeechUtterance(string:questionnaireList[questionIndex].question)
            speechSynthesizer.speak(speechUtterance)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnProceedTapped(_ sender: Any) {
        
        isNavigated = true
        
        var confirmData:ConfirmData = ConfirmData()
        
        for question in self.questionnaireList {
            
            switch question.questionID {
            case 1:
                confirmData.name = question.answer
                
                let attributedString:NSMutableAttributedString = NSMutableAttributedString()
                confirmData.attributedName = attributedString.formatString(framedAnswer: question.answerFramed, value: question.answer ?? "")
                
            case 4:
                let attributedString:NSMutableAttributedString = NSMutableAttributedString()
                confirmData.pax = attributedString.formatString(framedAnswer: question.answerFramed, value: question.answer ?? "")
            case 6:
                let attributedString:NSMutableAttributedString = NSMutableAttributedString()
                confirmData.travellingDate = attributedString.formatString(framedAnswer: question.answerFramed, value: question.answer ?? "")
            case 8:
                let attributedString:NSMutableAttributedString = NSMutableAttributedString()
                confirmData.email = attributedString.formatString(framedAnswer: question.answerFramed, value: question.answer ?? "")
            case 9:
                let attributedString:NSMutableAttributedString = NSMutableAttributedString()
                confirmData.phone = attributedString.formatString(framedAnswer: question.answerFramed, value: question.answer ?? "")
            case 5:
                let attributedString:NSMutableAttributedString = NSMutableAttributedString()
                confirmData.visaType = attributedString.formatString(framedAnswer: question.answerFramed, value: question.answer ?? "")
            default:
                print("Default")
            }
        }
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
        let eVisaVC = storyboard.instantiateViewController(withIdentifier: Constant.VIEWCONTROLLER_CONFIRMATION) as! ConfirmationVC
        setBackTitle(title: "eVisa")
        eVisaVC.confirmData = confirmData
        self.navigationController?.pushViewController(eVisaVC, animated: true)
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        
        if btnNext.isSelected == true {
            
            btnNext.isSelected = false
            tblChats.reloadRows(at: [IndexPath(row: questionIndex, section: 0)], with: .automatic)
            tblChats.scrollToRow(at: IndexPath(row: questionIndex, section: 0), at: .top, animated: true)
            speechController.stopRecording()
        }
    }
    
    func nextQuestion() {
        
        isValidatingAnswer = false
            
        if questionnaireList[questionIndex].answer == nil {
            askQuestion(index: questionIndex)
        }
        else {
                
            if questionnaireList[rowCount - 1].answer == nil {
                questionIndex = rowCount - 1
                askQuestion(index: questionIndex)
            }
            else {
                if rowCount != questionnaireList.count {
                        
                    rowCount = rowCount + 1
                    questionIndex = rowCount - 1
                    askQuestion(index: questionIndex)
                }
                else {
                    btnProceed.isHidden = false
                    btnNext.isHidden = true
                }
            }
        }
    }
    
    func askQuestionToValidate() {
        
        if questionIndex < questionnaireList.count {
            let verifyingQuestion = "You have answered \(questionnaireList[questionIndex].answer!), say yes to confirm and no to repeat."
          
            let speechUtterance = AVSpeechUtterance(string:verifyingQuestion)
            speechSynthesizer.speak(speechUtterance)
        }
    }
}

//MARK:- UITableViewDataSource
extension NewVoiceVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier) as! ChatCell
        
        cell.delegate = self
        cell.btnEdit.tag = indexPath.row
        
        if rowSelected == indexPath.row {
            
            cell.btnEdit.isSelected = true
        }
        else {
            cell.btnEdit.isSelected = false
        }
        cell.setData(questionnaireList[indexPath.row])
        
        return cell
    }
}

//MARK:- UITableViewDelegate
extension NewVoiceVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK:- AVSpeechSynthesizerDelegate
extension NewVoiceVC :AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        speechSynthesizer.stopSpeaking(at: .word)
        speechController.startRecording()
    }
}
//MARK:- ChatCellDelegate
extension NewVoiceVC : ChatCellDelagate {
    
    func btnEditTapped(sender: UIButton) {
        
        questionIndex = sender.tag
        rowSelected = sender.tag
        questionnaireList[questionIndex].isValid = false
         speechController.stopRecording()
       // askQuestion(index: questionIndex)
        btnProceed.isHidden = true
        btnNext.isHidden = false
        //sender.isSelected = true
    }
}

//MARK:- SpeechControllerDelegate
extension NewVoiceVC : SpeechControllerDelegate {
    
    func capturedText(capturedText: String) {
        
            if capturedText.lowercased() == "yes" {
                
                questionnaireList[questionIndex].isValid = true
                speechController.stopRecording()
            }
            else if capturedText.lowercased() == "no" {
                
                questionnaireList[questionIndex].isValid = false
                speechController.stopRecording()
            }
            else {
                 questionnaireList[questionIndex].answer = capturedText
                if questionIndex == 0 {
                    questionnaireList[1].question = "So, \(String(describing: self.passengerName ?? "")) what is your last name?"
                    print(self.questionnaireList[1].question)
                }
                
                rowSelected = nil
                
                tblChats.reloadRows(at: [IndexPath(row: questionIndex, section: 0)], with: .automatic)
                tblChats.scrollToRow(at: IndexPath(row: questionIndex, section: 0), at: .top, animated: true)
            }
        
        if rowCount == questionnaireList.count && questionnaireList[rowCount - 1].answer != nil {
            
            btnProceed.isHidden = false
            btnNext.isHidden = true
        }
    }
    
    func viewUpdateOnStopRecording() {
        btnNext.isSelected = false
        
        if let result = questionnaireList[questionIndex].isValid  {
            
            if result{
                 nextQuestion()
            }
            else {
                questionnaireList[questionIndex].isValid = nil
                askQuestion(index: questionIndex)
            }
        }
        else {
            askQuestionToValidate()
        }
    }
    
    func viewUpdateOnStartRecording() {
        btnNext.isSelected = true
    }
}
