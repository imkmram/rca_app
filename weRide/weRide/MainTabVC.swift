//
//  MainTab.swift
//  weRide
//
//  Created by Ashok Gupta on 25/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        //self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
