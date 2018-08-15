//
//  ChatCell.swift
//  RCA
//
//  Created by TWC on 03/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol ChatCellDelagate:class {
    func btnEditTapped(sender:UIButton)
}

class ChatCell: BaseTableViewCell {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblFramedAnswer: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    
    weak var delegate:ChatCellDelagate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        answerView.layer.cornerRadius = 8.0
        lblQuestion.layer.cornerRadius = lblQuestion.frame.height / 2
        lblQuestion.layer.masksToBounds = true
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    override func setData(_ data: Any?) {
        
        if let data = data as? Questionnaire {
            
            lblQuestion.text = data.question
            
            //  answerView.isHidden = data.answer.length == 0 ? true : false
            
            if let value = data.answer {
                    answerView.isHidden = false
                    lblFramedAnswer.text = data.answerFramed.replacingOccurrences(of: "{{value}}", with: value)
                
                let attributedString:NSMutableAttributedString = NSMutableAttributedString()
                
                if data.isValid {
                    lblFramedAnswer.attributedText = attributedString.formatString(framedAnswer: data.answerFramed, value: value)
                }
                else {
                    lblFramedAnswer.attributedText = attributedString.formatStringForError(framedAnswer: data.answer!, value: value)
                }
            }
            else {
                 answerView.isHidden = true
            }
        }
        
        if btnEdit.isSelected  {
            
            guard let url = Bundle.main.url(forResource: "speech", withExtension: "gif") else {
                return
            }
            
            do {
                let imgData :Data = try Data(contentsOf: url)
                let testImage = UIImage.sd_animatedGIF(with: imgData)
                btnEdit.setImage(testImage, for: .selected)
            }
            catch {
                
            }
        }
        else {
            btnEdit.setImage(UIImage(named: "voice"), for: .normal)
        }
    }
    
    @IBAction func btnEditTapped(_ sender: UIButton) {
        delegate?.btnEditTapped(sender: sender)
    }
}
