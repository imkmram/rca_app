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
extension BaseVC : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}

