//
//  DetailImageCell.swift
//  RCA
//
//  Created by Ashok Gupta on 20/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class DetailImageCell: BaseTableViewCell {
    @IBOutlet weak var sliderContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
   override func setData(_ data: Any?) {
        
        let sliderView: ImageSliderView = ImageSliderView(frame: CGRect(x: 0, y: 0, width: sliderContentView.bounds.size.width, height: sliderContentView.bounds.size.height))
        sliderView.initializeView(list: [UIImage(named: "error.jpg")!, UIImage(named: "error.jpg")!])
        sliderContentView.addSubview(sliderView)
    }

}
