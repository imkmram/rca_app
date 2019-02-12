//
//  MyTripPresenter.swift
//  weRide
//
//  Created by Ashok Gupta on 09/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

class MyTripPresenter {
    
    private var tripView :GeneralView?
    private var dataManager:DataManager = DataManager()
    private var strURL:String?
    
    func attachView(view:GeneralView) {
        tripView = view
    }
    
    func detachView() {
        tripView = nil
    }
    
    func getMyRides() {
        
        tripView?.startLoading()
        
        let dataManager = DataManager()
        
        let param: [String:Any] = ["method":Constant.kMyRides,
                                   "user_id" : UserDefaults.standard.getUserID()
        ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        self.parseMyRidesResponse(data: responseModel)
                    }
                    catch {
                    }
                }
                else {
                }
                DispatchQueue.main.async {
                    self.tripView?.stopLoading()
                }
            }
        }
    }
    
    func parseMyRidesResponse(data: BaseModel) {
        
        if let value = data.content?.result_set {
            tripView?.setList(list: value)
        }
    }
    
    func deleteRide(data: Result_set) {
        
        tripView?.startLoading()
        let dataManager = DataManager()
        
        let param: [String:Any] = ["method" : Constant.kDeleteRide,
                                   "ride_id" : data.ride_id!
        ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        if responseModel.status == Constant.kSuccess {
                            
                            self.tripView?.showMessage(message: CustomError.Delete, title: "Success", reCall: true)
                        }
                    }
                    catch {
                        print("TRY BEEN CAUGHT")
                    }
                }
                else {
                    
                   self.tripView?.showMessage(message: CustomError.BadRequest, title: "Error", reCall: false)
                }
                DispatchQueue.main.async {
                    self.tripView?.stopLoading()
                }
            }
        }
    }
}
