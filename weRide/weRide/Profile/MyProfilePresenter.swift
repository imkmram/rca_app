//
//  MyProfilePresenter.swift
//  weRide
//
//  Created by Ashok Gupta on 15/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

class MyProfilePresenter {
    
    private var profileView: GeneralView?
    
    func attachView(view:GeneralView) {
        profileView = view
    }
    
    func detachView() {
        profileView = nil
    }
    
    func updateProfile(userName: String, userMobileNo: String, imgData: Data?) {
        
        profileView?.startLoading()
        
        let dataManager = DataManager()
        
        let param: [String:Any] = ["method" : Constant.kUpdateProfile,
                                   "user_id" : UserDefaults.standard.getUserID(),
                                   "user_name" : userName,
                                   "user_mobile_no" : userMobileNo
                                   ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getDataWithImage(requestType: "POST", url: url, _params: param, imgData: imgData) { (data, error) in
                
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
                    self.profileView?.showMessage(message: CustomError.BadRequest, title: "Error", reCall: false)
                }
                DispatchQueue.main.async {
                    self.profileView?.stopLoading()
                }
            }
        }
    }
    
  private func parseResponse(data: BaseModel) {
        
        if data.status == Constant.kSuccess {
            
            guard let list = data.content?.result_set else {
                return
            }
            
            if list.count > 0 {
                
                self.profileView?.showMessage(message: CustomError.Success, title: "Success", reCall: false)
                self.profileView?.setList(list: list)
            }
            else {
                self.profileView?.showMessage(message: CustomError.DatabaseError, title: "Error", reCall: false)
            }
        }
        else {
            self.profileView?.showMessage(message: CustomError.DatabaseError, title: "Error", reCall: false)
        }
    }
}
