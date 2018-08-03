//
//  LeftMenuVC.swift
//  RCA
//
//  Created by TWC on 01/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case home = 0
    case about_us
    case privacy_policy
//    case nonMenu
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftMenuVC: UIViewController {

    @IBOutlet weak var tblMenu: UITableView!
    
    var menus = ["Home", "About Us", "Privacy Plolicy"]
    
    var homeVC: UIViewController!
    var aboutUsVC: UIViewController!
    var privacyPolicyVC: UIViewController!
    
   // var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMenu.registerCellClass(BaseTableViewCell.self)
        tblMenu.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        self.homeVC = UINavigationController(rootViewController: homeVC)
        
        let aboutUsVC = storyboard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
        self.aboutUsVC = UINavigationController(rootViewController: aboutUsVC)
        
        let privacyVC = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
        self.privacyPolicyVC = UINavigationController(rootViewController: privacyVC)
        
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
//        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
      //  self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            self.slideMenuController()?.changeMainViewController(self.homeVC, close: true)
        case .about_us:
            self.slideMenuController()?.changeMainViewController(self.aboutUsVC, close: true)
        case .privacy_policy:
            self.slideMenuController()?.changeMainViewController(self.privacyPolicyVC, close: true)
//        case .nonMenu:
//            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }
}

extension LeftMenuVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let identifier = "cell"
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier)!
//        cell.textLabel?.text = menus[indexPath.row]
//        return cell
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            
            switch menu {
                case .home, .about_us, .privacy_policy:
                
                let cell = BaseTableViewCell(style: .default, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                
                cell.layer.shadowOffset = CGSize(width: 1, height: 0)
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowRadius = 5;
                cell.layer.shadowOpacity = 0.25;
                
//                CGRect shadowFrame = cell.layer.bounds;
//                CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
//                cell.layer.shadowPath = shadowPath;
                
                let shawdowFrame:CGRect = cell.layer.bounds
                let beizerPath:UIBezierPath = UIBezierPath(rect: shawdowFrame)
                let shawdowPath:CGPath = beizerPath.cgPath
                cell.layer.shadowPath = shawdowPath
                
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension LeftMenuVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home, .about_us, .privacy_policy:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if self.tableView == scrollView {
//
//        }
//    }
}
