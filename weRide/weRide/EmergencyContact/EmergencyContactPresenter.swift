//
//  EmergencyContactPresenter.swift
//  weRide
//
//  Created by Ashok Gupta on 10/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

class EmergencyContactPresenter {
    
    private var contactView :GeneralView?
   
    func attachView(view:GeneralView) {
        contactView = view
    }
    
    func detachView() {
        contactView = nil
    }
    
    func getContactList() {
        
        contactView?.startLoading()
        
        let dataManager = DataManager()
        
        let param: [String:Any] = ["method" : Constant.kGetEmergencyContact,
                                   "user_id" : UserDefaults.standard.getUserID(),
                                   ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
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
                    self.contactView?.showMessage(message: CustomError.BadRequest, title: "Error", reCall: false)
                }
                DispatchQueue.main.async {
                    self.contactView?.stopLoading()
                }
            }
        }
    }
    
    func parseResponse(data: BaseModel) {
        
        if data.status == Constant.kSuccess {
            
            guard let list = data.content?.result_set else {
                return
            }
            
            if list.count > 0 {
                self.contactView?.setList(list: list)
            }
            else {
                    self.contactView?.showMessage(message: CustomError.NoData, title: "Message", reCall: false)
                }
            }
        else {
             self.contactView?.showMessage(message: CustomError.DatabaseError, title: "Error", reCall: false)
        }
    }
    
    func deleteContact(data: Result_set) {
        self.contactView?.startLoading()
        
        let dataManager = DataManager()
        
        let param: [String:Any] = ["method" : Constant.kDeleteEmergencyContact,
                                   "ec_id" : data.contact_id!
        ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        if responseModel.status == Constant.kSuccess {
                            
                            self.contactView?.showMessage(message:  CustomError.Delete, title: "Success", reCall: true)
                        }
                    }
                    catch {
                        print("TRY BEEN CAUGHT")
                    }
                }
                else {
                    
                     self.contactView?.showMessage(message:  CustomError.BadRequest, title: "Error", reCall: false)
                }
                DispatchQueue.main.async {
                    self.contactView?.stopLoading()
                }
            }
        }
    }
}
