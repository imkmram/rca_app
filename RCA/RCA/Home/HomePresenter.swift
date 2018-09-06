//
//  HomePresenter.swift
//  RCA
//
//  Created by TWC on 26/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: BasePresenter {
    
    weak private var homeView :HomeView?
   // private lazy var dataManager:DataManager = DataManager()
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

         let param: [String:Any] = ["method":Constant.HOME_METHOD_NAME]
    
         DataManager.getData(requestType: "POST", url: url, parameter: param) { (data, error) in
                
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
    
   private func parseData(data:Data?, success:Bool, error:CustomError?) {
        
         homeView?.stopLoading()
        if success {
           
            let jsonDecoder = JSONDecoder()
           
            do {
                var baseData: BaseModel?
                baseData = try jsonDecoder.decode(BaseModel.self, from: data!)
                let content = baseData?.content
                
                guard let result = content?.result_set else {
                    return
                }
               
                var test:[[String:Any]] = []
                
                let dict:[String:Any] = ["title":"eVisa", "list":result.evisa_countries!]
                let dict1:[String:Any] = ["title":"Meet & Assist", "list":result.mna_airports!]
                let dict2:[String:Any] = ["title":"Lounge", "list":result.lounge_airports!]
                
                test.append(dict)
                test.append(dict1)
                test.append(dict2)
                
                homeView?.setList(data: test, success: true)
                
            } catch {
                
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
