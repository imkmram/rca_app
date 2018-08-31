//
//  ViewController.swift
//  RCA
//
//  Created by TWC on 25/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import Crashlytics
import Speech
import CoreData

class ViewController: BaseVC {
    
    private let presenter = HomePresenter()

    //MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        presenter.attachView(view: self)
        
        super.delagate = self
        
        if NetworkManager.shared.isNetworkAvailable {
           //presenter.getData(strURL: "www.google.com")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
     //   NetworkManager.shared.addListener(listener: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.detachView()
       // NetworkManager.shared.removeListener(listener: self)
    }
    
    @IBAction func btnSpeakTapped(_ sender: Any) {
        
//        let formVC = self.storyboard?.instantiateViewController(withIdentifier: "FormVC") as! FormVC
//        self.present(formVC, animated: true, completion: nil)
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        
        let coreDataService :BaseCoreService = BaseCoreService()
        
        let context = coreDataService.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PassportType", in: context)
        
        let passportData = PassportType(entity: entity!, insertInto: context)
        
        //let  passportData = NSEntityDescription.insertNewObject(forEntityName: "PassportType", into: coreDataService.managedObjectContext) as! PassportType
        
        passportData.type_id = 100
        passportData.type_name = "See"
        passportData.type_code = "You"
    
        coreDataService.saveContext()
    }
    
    @IBAction func getDataTapped(_ sender: Any) {
        
//        let passportType = PassportType()
//        let list = passportType.getAllDataFromBD()
//        print(list)
//        
//        for data in list {
//            print("===========\(data.type_name!)========")
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:HomeView {
    func emptyList(error: CustomError, success: Bool) {
    }
    
    func setList(data: [Service]?, success: Bool) {
    }
    
    func setList<T>(data: [T]) {
    }
}

extension ViewController:BaseViewDelegate {

    func networkStausChanged(isReachable: Bool) {

       // if isReachable {

          //  presenter.reloadDataCall()

//        }
//        else {
//            presenter.pauseDataCall()
//        }
    }
}

//extension ViewController : SlideMenuControllerDelegate {
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

//extension ViewController:NetworkStatusListener {
//
//  func networkStatusDidChanged(status: Reachability.NetworkStatus) {
//
//        switch status {
//
//        case .notReachable:
//            print("Not Connected")
//
//        case .reachableViaWiFi, .reachableViaWWAN:
//            print("Connected")
//
//        }
//    }
//}
