//
//  AttributedString.swift
//  RCA
//
//  Created by TWC on 08/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

//import Foundation
import UIKit

public extension NSMutableAttributedString {
    
    func formatString(framedAnswer:String, value:String) -> NSMutableAttributedString {
        
        // Set initial attributed string
        let initialString = framedAnswer
        let attributes = [NSAttributedStringKey.font: UIFont(name: "OpenSans-Regular", size: 15.0)!]
        let mutableAttributedString = NSMutableAttributedString(string: initialString, attributes: attributes)
        
        // Set new attributed string
        let newString = value
        let newAttributes = [NSAttributedStringKey.font: UIFont(name: "OpenSans-Bold", size: 20.0)!]
        let newAttributedString = NSMutableAttributedString(string: newString, attributes: newAttributes)
        
        // Get range of text to replace
        guard let range = mutableAttributedString.string.range(of: "{{value}}") else {
            exit(0)
        }
        let nsRange = NSRange(range, in: mutableAttributedString.string)
        
        // Replace content in range with the new content
        mutableAttributedString.replaceCharacters(in: nsRange, with: newAttributedString)
        
        return mutableAttributedString
    }
    
    func formatStringForError(framedAnswer:String, value:String) -> NSMutableAttributedString {
        
        let initialString = framedAnswer
        let attributes = [NSAttributedStringKey.font: UIFont(name: "OpenSans-Regular", size: 12.0)!, NSAttributedStringKey.foregroundColor:UIColor.red]
        let mutableAttributedString = NSMutableAttributedString(string: initialString, attributes: attributes)
        
        return mutableAttributedString
    }
}
