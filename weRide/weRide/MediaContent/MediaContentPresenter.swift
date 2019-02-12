//
//  MediaContentPresenter.swift
//  weRide
//
//  Created by Ashok Gupta on 01/11/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

protocol MediaContentVIew: GeneralView {
    func updateCommentList()
    func updateImaggeListList()
}

class MediaContentPresenter {
    
    var contentView: MediaContentVIew?
    var dataManager: DataManager = DataManager()
    
    func attachView(view: MediaContentVIew) {
        contentView = view
    }
    
    func detachView() {
        contentView = nil
    }
    
    func getData(wayID: String) {
        
        guard let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) else {
            return
        }
        
        contentView?.startLoading()
        
        let param:[String:Any] = [
            "method":Constant.kWayPointData,
            "waypoint_id":wayID
        ]
        
        dataManager.getData(requestType: "POST", url: url, parameter: param) { (data, error) in
            
            if error == nil {
                
                let jsonDecoder = JSONDecoder()
                do {
                    let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                    self.parseResponse(data: responseModel)
                }
                catch {
                    print("TRY BEEN CAUGHT")
                }
            }
            else {
                self.contentView?.showMessage(message: CustomError.BadRequest, title: "Error", reCall: false)
            }
            DispatchQueue.main.async {
                self.contentView?.stopLoading()
            }
        }
    }
    private func parseResponse(data: BaseModel) {
        
        if data.status == Constant.kSuccess {
            guard let list = data.content?.result_set else {
                return
            }
            
            if list.count > 0 {
                self.contentView?.setList(list: list)
            }
            else {
                self.contentView?.showMessage(message: CustomError.NoData, title: "Message", reCall: false)
            }
        }
        else {
            self.contentView?.showMessage(message: CustomError.DatabaseError, title: "Error", reCall: false)
        }
    }
    
    func addComment(wayID: String, comment: String) {
        
        guard let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) else {
            return
        }
        let param:[String:Any] = [
            "method": Constant.kAddCommment,
            "waypoint_id":wayID,
            "comment":comment,
            "user_id":UserDefaults.standard.getUserID(),
            ]
        dataManager.getData(requestType: "POST", url: url, parameter: param) { (data, error) in
            if error == nil {
                
                let jsonDecoder = JSONDecoder()
                do {
                    let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                   
                    if responseModel.status == Constant.kSuccess {
                        DispatchQueue.main.async {
                             self.contentView?.updateCommentList()
                        }
                    }
                }
                catch {
                    print("TRY BEEN CAUGHT")
                }
            }
            else {
//                self.contentView?.showMessage(message: CustomError.BadRequest, title: "Error", reCall: false)
            }
        }
    }
}
