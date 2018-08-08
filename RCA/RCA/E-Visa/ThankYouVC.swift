//
//  ThankYouVC.swift
//  RCA
//
//  Created by TWC on 07/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class ThankYouVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    var name:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnhomeTapped(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
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
