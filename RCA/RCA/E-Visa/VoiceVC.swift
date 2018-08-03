//
//  VoiceVC.swift
//  RCA
//
//  Created by TWC on 03/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class VoiceVC: UIViewController {

    @IBOutlet weak var tblChats: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblChats.registerCellNib(ChatCell.self)
        tblChats.rowHeight = UITableViewAutomaticDimension
        tblChats.estimatedRowHeight = 160
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

extension VoiceVC : UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier) as! ChatCell
           
            return cell
//        }
//
//        return UITableViewCell()
    }
}

extension VoiceVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        if indexPath.row == 0 {
        //            let storyboard = UIStoryboard(name: "E-visa", bundle: nil)
        //            let eVisaVC = storyboard.instantiateViewController(withIdentifier: "E_VisaVC") as! E_VisaVC
        //            let backItem = UIBarButtonItem()
        //            backItem.title = "Back"
        //            navigationItem.backBarButtonItem = backItem
        //            self.navigationController?.pushViewController(eVisaVC, animated: true)
        //        }
    }
}
