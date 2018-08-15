//
//  HomeVC.swift
//  RCA
//
//  Created by TWC on 02/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

struct Service {
    
    var title:String?
    var description:String?
    var image:UIImage?
}

class HomeVC: BaseVC {

    @IBOutlet weak var tblHome: UITableView!
    var serviceList :[Service] = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblHome.registerCellNib(HomeCell.self)
        tblHome.rowHeight = UITableViewAutomaticDimension
        tblHome.estimatedRowHeight = 160
        
        serviceList.append(Service(title: "eVisa", description: "eVisa service", image: #imageLiteral(resourceName: "e_visa")))
        serviceList.append(Service(title: "Airport Meet & Greet", description: "Coming Soon", image:#imageLiteral(resourceName: "meet_n_assist")))
        serviceList.append(Service(title: "Airport Lounges", description: "Coming Soon", image: #imageLiteral(resourceName: "lounges")))
        serviceList.append(Service(title: "Document Repository", description: "Coming Soon", image: #imageLiteral(resourceName: "e_visa")))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationBarItem()
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

extension HomeVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return serviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier) as! HomeCell
        let data : Service = serviceList[indexPath.row]
        cell.setData(data)
        return cell
    }
}

extension HomeVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
            let eVisaVC = storyboard.instantiateViewController(withIdentifier: Constant.VIEWCONTROLLER_E_VISA) as! E_VisaVC
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(eVisaVC, animated: true)
        }
    }
}

//extension HomeVC : SlideMenuControllerDelegate {
//
//    func leftWillOpen() {
//        print("SlideMenuControllerDelegate: leftWillOpen")
//    }
//
//    func leftDidOpen() {
//        print("SlideMenuControllerDelegate: leftDidOpen")
//    }
//
//    func leftWillClose() {
//        print("SlideMenuControllerDelegate: leftWillClose")
//    }
//
//    func leftDidClose() {
//        print("SlideMenuControllerDelegate: leftDidClose")
//    }
//    
//    func rightWillOpen() {
//        print("SlideMenuControllerDelegate: rightWillOpen")
//    }
//
//    func rightDidOpen() {
//        print("SlideMenuControllerDelegate: rightDidOpen")
//    }
//
//    func rightWillClose() {
//        print("SlideMenuControllerDelegate: rightWillClose")
//    }
//
//    func rightDidClose() {
//        print("SlideMenuControllerDelegate: rightDidClose")
//    }
//}
