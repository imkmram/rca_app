//
//  ImagePageViewContentVC.swift
//  RCA
//
//  Created by Ashok Gupta on 21/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class ImagePageViewContentVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    var pageIndex: Int = 0
    private var img:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(data:UIImage) {
        print(data)
        //self.img = data
        imgView.image = data
        
    }
}
