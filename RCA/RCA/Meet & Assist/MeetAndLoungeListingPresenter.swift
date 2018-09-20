//
//  MeetAndLoungeListingPresenter.swift
//  RCA
//
//  Created by Ashok Gupta on 19/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

class MeetAndLoungeListingPresenter: BasePresenter {
    
    weak private var view :MeetAndLoungeView?

    private var dataManager:DataManager = DataManager()
    private var strURL:String?
    private var getURL:String {
        get {
            return strURL ?? ""
        }
    }
    
    func attachView(view:MeetAndLoungeView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    override func getData(strURL: String, param: [String : Any]) {
        self.strURL = strURL
        view?.startLoading()
        
        guard  let url = URL(string: strURL) else {
            return
        }
        
        dataManager.getData(requestType: "POST", url: url, parameter: param) { (data, error) in
            
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
        view?.stopLoading()
        
        if success {
            
            let jsonDecoder = JSONDecoder()
            
            do {
                var baseData: BaseModel?
                baseData = try jsonDecoder.decode(BaseModel.self, from: data!)
                let content = baseData?.content
                
                guard let result = content?.result_set else {
                    return
                }
                
                if let resultData = result.mna_product_list {
                    view?.setList(list: resultData)
                }
                else {
                     view?.setList(list: result.lounge_product_list!)
                }
               
            } catch {
                
            }
        }
        else {
            DispatchQueue.main.async {
                self.view?.emptyList(error: error ?? CustomError.OtherError, success: false)
            }
        }
    }
    
//    func reloadDataCall() {
//
//        guard let state :URLSessionTask.State = (loadData?.dataManager.taskState) else {
//            return
//        }
//
//        switch state {
//        case .running, .completed:
//            break
//        default:
//            getData(strURL: getURL)
//        }
//    }
//
//    func pauseDataCall() {
//
//        // DataManager.pause()
//    }
}
