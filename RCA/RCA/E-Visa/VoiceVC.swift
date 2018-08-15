//
//  VoiceVC.swift
//  RCA
//
//  Created by TWC on 03/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import Speech
import SDWebImage

struct Questionnaire {
    
    var questionID:Int
    var question:String
    var answer:String?
    var answerFramed:String
    var option:[String]?
    var isValid:Bool = false
   
    init(questionID:Int, question:String, answerFramed:String) {
        self.questionID = questionID
        self.question = question
        self.answerFramed = answerFramed
    }
    init(questionID:Int, question:String, answerFramed:String, opt:[String]) {
        self.init(questionID: questionID, question: question, answerFramed:answerFramed)
        self.option = opt
    }
}

class VoiceVC: UIViewController {

    @IBOutlet weak var bottomBaseView: UIView!
    @IBOutlet weak var tblChats: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblCapturedText: UILabel!
    @IBOutlet weak var btnProceed: RoundButton!
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-IN"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var questionnaireList: [Questionnaire] = [Questionnaire]()
    var rowCount: Int = 1
    var questionIndex: Int = 0
    var isNavigated: Bool = false
    
    var country:E_Visa = E_Visa()
    
    var passengerName:String?
    
    var timer : Timer?
    
    var rowSelected:Int?
    
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

    func askQuestion(index:Int) {
        
        if questionIndex < questionnaireList.count {
            tblChats.reloadData()
            tblChats.scrollToRow(at: IndexPath(row: questionIndex, section: 0), at: .top, animated: true)
            let speechUtterance = AVSpeechUtterance(string:questionnaireList[questionIndex].question)
            speechSynthesizer.speak(speechUtterance)
        }
    }
    
//    func startRecording() {
//
//        self.btnNext.isSelected = true
//
//        if recognitionTask != nil {
//            recognitionTask?.cancel()
//            recognitionTask = nil
//        }
//
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//            try audioSession.setMode(AVAudioSessionModeDefault)
//            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
//        } catch {
//            print("audioSession properties weren't set because of an error.")
//        }
//
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//
//         var inputnode:AVAudioInputNode?
//
//         inputnode = audioEngine.inputNode
//
//        guard let inputNode = inputnode else {
//            return
//           // fatalError("Audio engine has no input node")
//        }
//
//        guard let recognitionRequest = recognitionRequest else {
//            return
//            //fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
//        }
//
//        recognitionRequest.shouldReportPartialResults = true
//
//        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: {[unowned self]  (result, error) in  //7
//
//            //var isFinal = false
//
//            if result != nil {
//
//                // self.lblCapturedText.text = result?.bestTranscription.formattedString
//
//                let capturedText = result?.bestTranscription.formattedString
//
//                print("Captured Value : \(String(describing: capturedText!))")
//
//                if let value = capturedText {
//
//                    let validate = Validate()
//
//                    let validatedValue = validate.validate(value:value, questionID: self.questionnaireList[self.questionIndex].questionID)
//
//                    if self.questionIndex == 0 {
//
//                        self.passengerName = validatedValue
//
//                        self.questionnaireList[1].question = "So, \(String(describing: self.passengerName ?? "")) what is your last name?"
//                        print(self.questionnaireList[1].question)
//                    }
//
//                        self.rowSelected = nil
//
//                        self.questionnaireList[self.questionIndex].answer = validatedValue
//                        self.tblChats.reloadRows(at: [IndexPath(row: self.questionIndex, section: 0)], with: .automatic)
//                        self.tblChats.scrollToRow(at: IndexPath(row: self.questionIndex, section: 0), at: .top, animated: true)
//                }
//
//                if self.rowCount == self.questionnaireList.count && self.questionnaireList[self.rowCount - 1].answer != nil {
//
//                    self.btnProceed.isHidden = false
//                    self.btnNext.isHidden = true
//                }
////                 isFinal = (result?.isFinal)!
////
////                if isFinal {
////                    print("=============Final is true======================")
////                }
//
//            }
//
//         //   if error != nil || isFinal {
//            if result?.isFinal ?? (error != nil) {
//
//                self.audioEngine.stop()
//
//                inputNode.removeTap(onBus: 0)
//
//                self.recognitionRequest = nil
//                self.recognitionTask = nil
//
//                print("=====isFinal is true======")
//            }
//        })
//
//       let recordingFormat = inputNode.outputFormat(forBus: 0)
//
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
//            self.recognitionRequest?.append(buffer)
//        }
//
//        audioEngine.prepare()
//
//        do {
//            try audioEngine.start()
//        } catch {
//            print("audioEngine couldn't start because of an error.")
//        }
//
//       // lblCapturedText.text = "Say something, I'm listening!"
//    }
    
    func stopRecording() {
    
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
            recognitionTask?.cancel()
            
//             recognitionRequest = nil
//            recognitionTask = nil
           
            self.btnNext.isSelected = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newButtonFunctionality() {
        
        if btnNext.isSelected == true {
            btnNext.isSelected = false
            
            speechController.stopRecording()
            
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
        else {

        }
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
        
        newButtonFunctionality()
        
//        if btnNext.isSelected == true {
//
//            btnNext.isSelected = false
//            stopRecording()
//
//        }
//        else {
//
//            if questionnaireList[questionIndex].answer == nil {
//
//                askQuestion(index: questionIndex)
//            }
//            else {
//                if rowCount != questionnaireList.count {
//                    rowCount = rowCount + 1
//                    questionIndex = rowCount - 1
//                    askQuestion(index: questionIndex)
//                }
//                else {
//                    isNavigated = true
//
//                    var confirmData:ConfirmData = ConfirmData()
//
//                    for question in self.questionnaireList {
//
//                        switch question.questionID {
//                        case 1:
//                            confirmData.name = question.answer
//                            confirmData.framedName =  question.answerFramed.replacingOccurrences(of: "{{value}}", with: question.answer ?? "")
//                        case 2:
//                            confirmData.pax = question.answerFramed.replacingOccurrences(of: "{{value}}", with: question.answer ?? "")
//                        case 3:
//                            confirmData.travellingDate = question.answerFramed.replacingOccurrences(of: "{{value}}", with: question.answer ?? "")
//                        case 4:
//                            confirmData.email = question.answerFramed.replacingOccurrences(of: "{{value}}", with: question.answer ?? "")
//                        case 5:
//                            confirmData.phone = question.answerFramed.replacingOccurrences(of: "{{value}}", with: question.answer ?? "")
//                        default:
//                            print("Default")
//                        }
//                    }
//
//                    let storyboard = UIStoryboard(name: "E-visa", bundle: nil)
//                    let eVisaVC = storyboard.instantiateViewController(withIdentifier: "ConfirmationVC") as! ConfirmationVC
//                    setBackTitle(title: "eVisa")
//                    eVisaVC.confirmData = confirmData
//                    self.navigationController?.pushViewController(eVisaVC, animated: true)
//                }
//            }
//        }
    }
}

extension VoiceVC : UITableViewDataSource {
    
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

extension VoiceVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension VoiceVC :AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        speechSynthesizer.stopSpeaking(at: .word)
        //startRecording()
        speechController.startRecording()
    }
}

extension VoiceVC : ChatCellDelagate {
    
    func btnEditTapped(sender: UIButton) {
        
            questionIndex = sender.tag
            speechController.stopRecording()
            rowSelected = sender.tag
            askQuestion(index: questionIndex)
            btnProceed.isHidden = true
            btnNext.isHidden = false
            //sender.isSelected = true
    }
}

extension VoiceVC : SpeechControllerDelegate {
    
    func capturedText(capturedText: String) {
        
        let validate = Validate()
        
        let validatedValue = validate.validate(value:capturedText, questionID: questionnaireList[questionIndex].questionID)
        
            questionnaireList[questionIndex].isValid = validatedValue.1
        
        if questionIndex == 0 {
            
            passengerName = validatedValue.0
            questionnaireList[1].question = "So, \(String(describing: self.passengerName ?? "")) what is your last name?"
            print(self.questionnaireList[1].question)
        }
        
       rowSelected = nil
        
        questionnaireList[questionIndex].answer = validatedValue.0
        tblChats.reloadRows(at: [IndexPath(row: questionIndex, section: 0)], with: .automatic)
        tblChats.scrollToRow(at: IndexPath(row: questionIndex, section: 0), at: .top, animated: true)
    
        if rowCount == questionnaireList.count && questionnaireList[rowCount - 1].answer != nil {
    
            btnProceed.isHidden = false
            btnNext.isHidden = true
        }
    }
    
    func viewUpdateOnStopRecording() {
        btnNext.isSelected = false
    }
    
    func viewUpdateOnStartRecording() {
        btnNext.isSelected = true
    }
}
