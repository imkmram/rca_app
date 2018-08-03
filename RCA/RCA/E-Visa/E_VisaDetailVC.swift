//
//  E_VisaDetailVC.swift
//  RCA
//
//  Created by TWC on 03/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class E_VisaDetailVC: UIViewController {

    @IBOutlet weak var tblDetails: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblDetails.registerCellNib(BottomCell.self)
        tblDetails.rowHeight = UITableViewAutomaticDimension
        tblDetails.estimatedRowHeight = 160


        
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

extension E_VisaDetailVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BottomCell.identifier) as! BottomCell
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
}

extension E_VisaDetailVC : UITableViewDelegate {
    
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

extension E_VisaDetailVC : BottomCellDelegate {
    
    func btnVoiceTapped(sender: UIButton) {
        let storyboard = UIStoryboard(name: "E-visa", bundle: nil)
        let voiceVC = storyboard.instantiateViewController(withIdentifier: "VoiceVC") as! VoiceVC
//        let backItem = UIBarButtonItem()
//        backItem.title = "Back"
//        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(voiceVC, animated: true)
    }
    
    func btnManualTapped(sender: UIButton) {
        
    }
}
