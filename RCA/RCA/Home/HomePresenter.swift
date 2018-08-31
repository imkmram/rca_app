//
//  HomePresenter.swift
//  RCA
//
//  Created by TWC on 26/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation
import UIKit

struct Service {
    
    var title:String?
    var description:String?
    var image:UIImage?
}

class HomePresenter:BasePresenter {
    
    weak private var homeView :HomeView?
  //  private lazy var dataManager:DataManager = DataManager()
    private var strURL:String?
    private var getURL:String {
        get {
            return strURL ?? ""
        }
    }
    
    func attachView(view:HomeView) {
        homeView = view
    }
    
    func detachView() {
        homeView = nil
    }
    
    override func getData(strURL:String) {
        
        self.strURL = strURL
        
        homeView?.startLoading()
        
        guard  let url = URL(string: strURL) else {
            return
        }
        DataManager.getData(url: url) { (data, error) in
                
            if error == nil {    
                self.parseData(data: data, success: true, error: nil)
            }
            else {
                if  let customError = error as? CustomError {
                    print(String(describing: customError.localizedDescription))
                    self.parseData(data: nil, success: false, error: customError)
                }
            }
        }
    }
    
    func parseData(data:Data?, success:Bool, error:CustomError?) {
        
         homeView?.stopLoading()
        if success {
            var serviceList :[Service] = [Service]()
            
            serviceList.append(Service(title: "eVisa", description: "eVisa service", image: #imageLiteral(resourceName: "e_visa")))
            serviceList.append(Service(title: "Airport Meet & Greet", description: "Coming Soon", image:#imageLiteral(resourceName: "meet_n_assist")))
            serviceList.append(Service(title: "Airport Lounges", description: "Coming Soon", image: #imageLiteral(resourceName: "lounges")))
            serviceList.append(Service(title: "Document Repository", description: "Coming Soon", image: #imageLiteral(resourceName: "e_visa")))
            
            if(serviceList.count > 0){
                homeView?.setList(data: serviceList, success: true)
            }
        }
        else {
            DispatchQueue.main.async {
                self.homeView?.emptyList(error: error ?? CustomError.OtherError, success: false)
            }
        }
    }
    
    func reloadDataCall() {
        getData(strURL: getURL)
    }
    
    func pauseDataCall() {
        
       // DataManager.pause()
    }
}
