  //
//  LoadData.swift
//  RCA
//
//  Created by Ashok Gupta on 07/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation
import CoreData

protocol LoadDataDelegate:class {
    func updatePresenter()
}

class LoadData {
    
    var url: URL = URL(string: "https://www.google.com")!
    lazy var queue = OperationQueue()
    weak var delegate:LoadDataDelegate?
    lazy var dataManager = DataManager()
    
    public func checkDataVersion() {
        
        dataManager.getData(requestType: "GET", url: self.url, parameter: nil) { (data, error) in
            
            if error == nil {
                
                if UserDefaults.exists(key: Constant.DATABASE_VERSION) {
                    self.delegate?.updatePresenter()
                }
                else {
                    UserDefaults.standard.set("1.0", forKey: Constant.DATABASE_VERSION)
                    self.loadData()
                }
            }
            else {
                self.delegate?.updatePresenter()
            }
        }
    }
    
    private func loadData() {
        
        queue.addOperation {
            let param: [String:Any] = ["method":Constant.HOME_METHOD_NAME]
            
            let url = URL(string: Constant.HOME_REQUEST_URL)
            
            self.dataManager.getData(requestType: "POST", url: url!, parameter: param, completion: { (data, error) in
                
                if error == nil {
                    
                    self.parseData(data: data, success: true, error: nil)
                }
                else {
                    
                }
               // self.checkOperationState()
            })
        }
    }
    
   private func checkOperationState() {
    
        if queue.operations.count == 0 {
            delegate?.updatePresenter()
        }
    }
    
    private func parseData(data:Data?, success:Bool, error:CustomError?) {
        
        if success {
            
            let jsonDecoder = JSONDecoder()
            
            do {
                var baseData: BaseModel?
                baseData = try jsonDecoder.decode(BaseModel.self, from: data!)
                let content = baseData?.content
                
                guard let result = content?.result_set else {
                    return
                }
                ServiceCD.save(list: result.service_list!)
     
                delegate?.updatePresenter()
                
            } catch {
                
            }
        }
        else {
            DispatchQueue.main.async {
                // self.homeView?.emptyList(error: error ?? CustomError.OtherError, success: false)
            }
        }
    }
}


