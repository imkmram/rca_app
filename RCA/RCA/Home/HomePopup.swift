//
//  HomePopup.swift
//  RCA
//
//  Created by Ashok Gupta on 10/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol HomePopupDelegate:class{
    
    func btnContinueTapped()
}

class HomePopup: UIViewController {

    @IBOutlet weak var baseView: UIView!
    weak var delegate: HomePopupDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseView.layer.cornerRadius = 8.0
    }

    @IBAction func btnContinueTapped(_ sender: Any) {
        
        delegate?.btnContinueTapped()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
