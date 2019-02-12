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
         super.viewWillAppear(animated)
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
    
    func alertError(parent: UIViewController, error: CustomError, title: String, handler:@escaping ()-> Void) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                handler()
            }
            alert.addAction(action)
            parent.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertWarning(parent: UIViewController, message: CustomError, title: String, handler:@escaping (_ isOKClicked: Bool) -> Void) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title, message: message.localizedDescription, preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .cancel) { (action) in
                handler(true)
            }
            let actionCANCEL = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                handler(false)
            })
            
            alert.addAction(actionOK)
            alert.addAction(actionCANCEL)
            parent.present(alert, animated: true, completion: nil)
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
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
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
