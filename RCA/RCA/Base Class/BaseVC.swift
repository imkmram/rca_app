//
//  BaseVC.swift
//  RCA
//
//  Created by TWC on 26/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import ReachabilitySwift

protocol BaseViewDelegate: class {
    
    func networkStausChanged(isReachable:Bool)
}

class BaseVC: UIViewController {
    
    weak var delagate : BaseViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
         NetworkManager.shared.addListener(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NetworkManager.shared.removeListener(listener: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseVC:NetworkStatusListener {

    func networkStatusDidChanged(status: Reachability.NetworkStatus) {

        switch status {

        case .notReachable:
            print("Not Connected")
            delagate?.networkStausChanged(isReachable: false)

        case .reachableViaWiFi, .reachableViaWWAN:
            print("Connected")
             delagate?.networkStausChanged(isReachable: true)
        }
    }
}

extension BaseVC:BaseView {
    
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
}
