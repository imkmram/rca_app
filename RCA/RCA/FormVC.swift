//
//  FormVC.swift
//  RCA
//
//  Created by TWC on 27/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import Speech

struct Interaction {

    var question:String
    var answer:String
    var isAnswered:Bool
}

class FormVC: UIViewController {
    
    @IBOutlet weak var buttonRecord: UIButton!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var txtAnswer: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    var interactionList :[Interaction] = [Interaction]()
    var name:String?
    var questionIndex:Int = 0
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-IN"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        speechRecognizer.delegate = self

        interactionList = [Interaction(question: "Hey, What's your name", answer: "", isAnswered: false),
                           Interaction(question: "What's your age", answer: "", isAnswered: false),
                           Interaction(question: "Share your travel date", answer: "", isAnswered: false)
        ]
        
        askQuestion(index: questionIndex)
    }

    func stopCommunication() {
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            buttonRecord.isSelected = false
            btnNext.isEnabled = true
        }
    }
    
    func askQuestion(index:Int) {
        if questionIndex < interactionList.count {
           lblQuestion.text  = interactionList[questionIndex].question
            let speechUtterance = AVSpeechUtterance(string: lblQuestion.text!)
            speechSynthesizer.speak(speechUtterance)
        }
    }

    func startRecording() {
        
         btnNext.isEnabled = false
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }

        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7

            var isFinal = false

            if result != nil {

                self.txtAnswer.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
                inputNode.removeTap(onBus: 0)
                self.stopCommunication()
                var interaction = self.interactionList[self.questionIndex]
                interaction.answer = self.txtAnswer.text ?? ""
            }

            if error != nil || isFinal {
                
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.buttonRecord.isSelected = false
                self.stopCommunication()
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }

        txtAnswer.text = "Say something, I'm listening!"
    }
    
    @IBAction func buttonRecordAction() {
        buttonRecord.isSelected = !buttonRecord.isSelected
        if buttonRecord.isSelected {
            startRecording()
        }
    }

    @IBAction func btnNextAction() {

        questionIndex = questionIndex + 1
        
        if questionIndex < interactionList.count {
            askQuestion(index: questionIndex)
        }
    }
}

extension FormVC:AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        speechSynthesizer.pauseSpeaking(at: .word)
        buttonRecord.isSelected = true
        startRecording()
    }
}
