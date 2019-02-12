//
//  ProfileVC.swift
//  weRide
//
//  Created by Ashok Gupta on 24/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

struct Menu {
    
    var title: String
    var menuID: Int
    var image: UIImage
}

class MenuVC: BaseVC {
    
    @IBOutlet weak var tblProfile: UITableView!
    
    let profile:[Menu] = [Menu(title: "Profile", menuID: 1, image: #imageLiteral(resourceName: "myprofile"))]
    let extra:[Menu] = [Menu(title: "Manage Vehicle", menuID: 2, image: #imageLiteral(resourceName: "vehicle")), Menu(title: "Emergency Contacts", menuID: 3, image: #imageLiteral(resourceName: "emergencyNumber"))]
    let logout:[Menu] = [Menu(title: "Logout", menuID: 4, image: #imageLiteral(resourceName: "logout"))]
    
    var menuList:[[Menu]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
         menuList = [profile, extra, logout]
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.tabBarController?.navigationItem.setRightBarButton(nil, animated: true)
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        self.tabBarController?.navigationItem.title = "Profile"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MenuVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return menuList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let data: Menu = menuList[indexPath.section][indexPath.row]
        cell?.textLabel?.text = data.title
        cell?.imageView?.image = data.image
        if indexPath.section != 2 {
            cell?.accessoryType = .disclosureIndicator
        }
        if indexPath.section == 1 {
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        view.backgroundColor = UIColor.clear
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = menuList[indexPath.section][indexPath.row]
        
        switch data.menuID {
            
        case 1:
            
            let profileVC = Utils.profileStoryboardController(identifier: Constant.kMyProfileVC) as! MyProfileVC
            
            self.tabBarController?.navigationController?.navigationBar.isHidden = true
            if #available(iOS 11.0, *) {
                self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
            } else {
                // Fallback on earlier versions
            }
            self.tabBarController?.navigationController?.pushViewController(profileVC, animated: true)
        case 2:
            let manageVehicleVC = Utils.profileStoryboardController(identifier: Constant.kManageVehicle_VC) as! ManageVehicleVC
            
            self.tabBarController?.navigationController?.navigationBar.isHidden = true
            if #available(iOS 11.0, *) {
                self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
            } else {
                // Fallback on earlier versions
            }
            self.tabBarController?.navigationController?.pushViewController(manageVehicleVC, animated: true)
        case 3:
            
            let emergencyVC = Utils.profileStoryboardController(identifier: Constant.kEmergencyContact_VC) as! EmergencyContactVC
            
            self.tabBarController?.navigationController?.navigationBar.isHidden = true
            if #available(iOS 11.0, *) {
                self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
            } else {
                // Fallback on earlier versions
            }
            self.tabBarController?.navigationController?.pushViewController(emergencyVC, animated: true)
        case 4:
            
            alertWarning(parent: self, message: CustomError.Logout, title: "Warning!") { (isOKTapped) in
                if isOKTapped {
                    UserDefaults.standard.reset()
                    
                    let window = UIApplication.shared.keyWindow
                    let loginVC  = Utils.loginStoryboardController(identifier:Constant.kLogin_VC) as! LoginVC
                    let rootNav = window?.rootViewController as! UINavigationController
                    rootNav.setViewControllers([loginVC], animated: true)
                }
                else {
                }
            }
            
        default:
            break
        }
    }
}
