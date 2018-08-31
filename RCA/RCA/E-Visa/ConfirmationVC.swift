//
//  ConfirmationVC.swift
//  RCA
//
//  Created by TWC on 06/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
struct ConfirmData {
    
    var attributedName:NSMutableAttributedString?
    var framedName:NSMutableAttributedString?
    var name:String?
    var pax:NSMutableAttributedString?
    var travellingDate:NSMutableAttributedString?
    var visaType:NSMutableAttributedString?
    var email:NSMutableAttributedString?
    var phone:NSMutableAttributedString?
}

class ConfirmationVC: UIViewController {
    
    @IBOutlet weak var tblConfirmation: UITableView!
    public lazy var confirmData:ConfirmData = ConfirmData()

    override func viewDidLoad() {
        super.viewDidLoad()

        tblConfirmation.registerCellNib(ConfirmDataCell.self)
        tblConfirmation.rowHeight = UITableViewAutomaticDimension
        tblConfirmation.estimatedRowHeight = 160
        
        print(confirmData)
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
extension ConfirmationVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmDataCell.identifier) as! ConfirmDataCell
        
        cell.delegate = self
        cell.setData(confirmData)
        
        return cell
    }
}

extension ConfirmationVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ConfirmationVC : ConfirmDataCellDelegate {
    
    func btnConfirmTapped(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
        let thankyouVC = storyboard.instantiateViewController(withIdentifier: Constant.VIEWCONTROLLER_THANKYOU) as! ThankYouVC
        thankyouVC.name = confirmData.name
        self.navigationController?.pushViewController(thankyouVC, animated: true)
    }
}

