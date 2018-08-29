//
//  ErrorVC.swift
//  RCA
//
//  Created by Ashok Gupta on 28/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class ErrorVC: UIViewController {
    
    var message:String = "Opppssss, we will bw back!"

    @IBOutlet weak var lblMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        lblMessage.text = message
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
