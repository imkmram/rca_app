//
//  DetailDescCell.swift
//  RCA
//
//  Created by Ashok Gupta on 20/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class DetailDescCell: BaseTableViewCell {

    @IBOutlet weak var lblServiceOffered: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func setData(_ data: Any?) {
        
        if let productData = data as? MnA_ProductData {

         let strSummary = productData.service_description?.replacingOccurrences(of: "<p>", with: "")
             lblSummary.text = strSummary?.replacingOccurrences(of: "</p>", with: "")
            
            var strServiceProvided = productData.inclusions?.replacingOccurrences(of: "<ul>", with: "")
            strServiceProvided = strServiceProvided?.replacingOccurrences(of: "</ul>", with: "")
            strServiceProvided = strServiceProvided?.replacingOccurrences(of: "</li>", with: "")
            strServiceProvided = strServiceProvided?.replacingOccurrences(of: "<li>", with: "\n\n" + Utils.bullet + " " )
            
            //lblServiceOffered.attributedText = NSAttributedString(string: strServiceProvided!)
            lblServiceOffered.text = strServiceProvided
            
            
            
        
//            if let regex = try? NSRegularExpression(pattern: "(<[a-z 0-9 A-Z /]+>)", options: .caseInsensitive) {
//
//                var resut: String = ""
//
//                if let strDesc = productData.service_description {
//
//                    let matches = regex.matches(in: strDesc, options: [], range: NSRange(location: 0, length: strDesc.length))
//
//                    for match in matches {
//
//                        let startIndex = String.Index(encodedOffset: match.range.lowerBound)
//                        let endIndex = String.Index(encodedOffset: match.range.upperBound)
//
//                        strDesc.enumerateSubstrings(in: startIndex..<endIndex, options: []) { substring, _, _, _ in
//                            if let substring = substring {
//                               resut = strDesc.replacingOccurrences(of: substring, with: "")
//                            }
//                        }
//                    }
//
//                    lblSummary.text = resut
//                }
//            }
           
        }
    }
}
