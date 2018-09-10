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
    var loadData: LoadData?
    private var dataManager:DataManager = DataManager()
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
    
        loadData = LoadData()
        loadData?.delegate = self
        loadData?.checkDataVersion()

//         let param: [String:Any] = ["method":Constant.HOME_METHOD_NAME]
//
//         dataManager.getData(requestType: "POST", url: url, parameter: param) { (data, error) in
//
//            if error == nil {
//                self.parseData(data: data, success: true, error: nil)
//            }
//            else {
//                if  let customError = error as? CustomError {
//                    print(String(describing: customError.localizedDescription))
//                    self.parseData(data: nil, success: false, error: customError)
//                }
//            }
//        }
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
        
        guard let state :URLSessionTask.State = (loadData?.dataManager.taskState) else {
            return
        }
        
        switch state {
        case .running, .completed:
            break
        default:
             getData(strURL: getURL)
        }
    }
    
    func pauseDataCall() {
        
       // DataManager.pause()
    }
}

extension HomePresenter : LoadDataDelegate {
    func updatePresenter() {
        
        let serviceCD = ServiceCD()
        let evisaList = serviceCD.selectByProductID(productID: "1")
        let meetNgreetList = serviceCD.selectByProductID(productID: "2")
        let loungeList = serviceCD.selectByProductID(productID: "3")
        
        var test:[[String:Any]] = []
        
        let dict:[String:Any] = ["title":"eVisa", "list":createArrayList(listCD: evisaList)]
        let dict1:[String:Any] = ["title":"Meet & Assist", "list":createArrayList(listCD: meetNgreetList)]
        let dict2:[String:Any] = ["title":"Lounge", "list":createArrayList(listCD: loungeList)]
        
        test.append(dict)
        test.append(dict1)
        test.append(dict2)
        
        homeView?.stopLoading()
        homeView?.setList(data: test, success: true)
    }
    
    func createArrayList(listCD: [ServiceCD]) -> [Service_list] {
        
        var list:[Service_list] = []
        for item in listCD {
            list.append(Service_list(coredata: item))
        }
        return list
    }
}
