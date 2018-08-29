//
//  SpeechController.swift
//  RCA
//
//  Created by Ashok Gupta on 14/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation
import Speech

protocol SpeechControllerDelegate :class {
    
    func capturedText(capturedText:String)
    func viewUpdateOnStopRecording()
    func viewUpdateOnStartRecording()
}

class SpeechController {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-IN"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
   weak var delegate:SpeechControllerDelegate?
    
    private var timer = Timer()
    
    @objc func dismissAudio() {
//        timer.invalidate()
//        stopRecording()
    }
    
    func startRecording() {
        
        // timer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(dismissAudio), userInfo: nil, repeats: false)
        
        delegate?.viewUpdateOnStartRecording()
       
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setMode(AVAudioSessionModeDefault)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        var inputnode:AVAudioInputNode?
        
        inputnode = audioEngine.inputNode
        
        guard let inputNode = inputnode else {
            return
            // fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            return
            //fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: {[unowned self]  (result, error) in
            
            if result != nil {
                
              //  self.timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(self.dismissAudio), userInfo: nil, repeats: false)
            
                let capturedText = result?.bestTranscription.formattedString
                
                print("Captured Value : \(String(describing: capturedText!))")
                
                if let value = capturedText {
                    
                    self.delegate?.capturedText(capturedText: value)
                }
            }
            
            //   if error != nil || isFinal {
            if result?.isFinal ?? (error != nil) {
                
                self.audioEngine.stop()
                
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
               // self.timer.invalidate()
                
                
                print("=====isFinal is true======")
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
        
        // lblCapturedText.text = "Say something, I'm listening!"
    }
    
    func stopRecording() {
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
            recognitionTask?.cancel()
            
            delegate?.viewUpdateOnStopRecording()
            
            //             recognitionRequest = nil
            //            recognitionTask = nil
            
        }
    }
}



