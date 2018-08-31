//
//  BaseVC.swift
//  RCA
//
//  Created by TWC on 26/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol BaseViewDelegate: class {
    
    func networkStausChanged(isReachable:Bool)
}

class BaseVC: UIViewController {
    
    weak var delagate : BaseViewDelegate?
    
  //  var indicator:UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.addListener(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NetworkManager.shared.removeListener(listener: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadErrorPage(parent:UIViewController, error:CustomError) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let errorVC = storyboard.instantiateViewController(withIdentifier: "ErrorVC") as! ErrorVC
        errorVC.message = error.localizedDescription
        parent.addChildViewController(errorVC)
        parent.view.addSubview(errorVC.view)
        errorVC.didMove(toParentViewController: parent)
    }
    func removeErrorPage(parent:UIViewController) {
        
        for controller in parent.childViewControllers {
            if controller.isKind(of: ErrorVC.self){
                DispatchQueue.main.async {
                    controller.willMove(toParentViewController: nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParentViewController()
                }
            }
        }
    }
}

extension BaseVC: NetworkStatusListener {

    func networkStatusDidChanged(status: Reachability.Connection) {

        switch status {
        case .none:
            print("Not Connected")
            delagate?.networkStausChanged(isReachable: false)

        case .wifi, .cellular:
            print("Connected")
             delagate?.networkStausChanged(isReachable: true)
        }
    }
}

extension BaseVC:BaseView {
    
//    func errorPage(error:CustomError) {
//
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let errorVC = storyboard.instantiateViewController(withIdentifier: "ErrorVC") as! ErrorVC
//        errorVC.message = error.localizedDescription
//        self.addChildViewController(errorVC)
//        self.view.addSubview(errorVC.view)
//        errorVC.didMove(toParentViewController: self)
//    }
//
//    func loadingPage() {
//        removeErrorPage()
//    }
    
    func startLoading() {
        SVProgressHUD.show()
    }
    
    func stopLoading() {
        SVProgressHUD.dismiss()
    }
    
    private func removeErrorPage() {
        
        for controller in childViewControllers {
            if controller.isKind(of: ErrorVC.self){
                DispatchQueue.main.async {
                    controller.willMove(toParentViewController: nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParentViewController()
                }
            }
        }
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

