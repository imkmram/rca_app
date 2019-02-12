//
//  DocumentCell.swift
//  FaceVision
//
//  Created by Ashok Gupta on 22/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import UIKit

class DocumentCell: UITableViewCell {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var innerRadioView: UIView!
    @IBOutlet weak var outerRadioView: UIView!
    
    @IBOutlet weak var lblMaxSize: UILabel!
    @IBOutlet weak var lblResolution: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblDocumentTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        baseView.layer.cornerRadius = 10.0
        
        outerRadioView.layer.cornerRadius = outerRadioView.bounds.width / 2
        outerRadioView.layer.borderWidth = 1.5
        outerRadioView.layer.borderColor = UIColor.black.cgColor
        
        innerRadioView.layer.cornerRadius = innerRadioView.bounds.width / 2
        innerRadioView.layer.borderWidth = 1.5
        innerRadioView.layer.borderColor = UIColor.black.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: Document) {
        
        if let title = data.doc_name {
            lblDocumentTitle.text = title
        }
        
        lblSize.text = data.doc_size
        
//        if let width = data.size?.width, let height = data.size?.height {
//            lblSize.text = String(format: "%.2f INCH x %.2f INCH", arguments: [width, height])
//        }
        
    }
}
