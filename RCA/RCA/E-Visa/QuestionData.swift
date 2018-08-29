//
//  Question.swift
//  RCA
//
//  Created by Ashok Gupta on 16/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation
import UIKit

class QuestionData {
    
    var questionID:Int?
    var question:String?
    var answer:String?
    var tapIdentifier:String?
    var range:NSRange?
    var rect:CGRect?
    
    init(question:String) {
        self.question = question
    }
    
    convenience init(questionID:Int, question:String, identifier:String) {
        self.init(question: question)
        self.questionID = questionID
        self.tapIdentifier = identifier
    }
}
