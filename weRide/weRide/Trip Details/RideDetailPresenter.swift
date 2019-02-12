//
//  RideDetailPresenter.swift
//  weRide
//
//  Created by Ashok Gupta on 16/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation

protocol RideDetailView: GeneralView {
    func getRideData() -> RideData
    func updateRideID(rideID: String)
}

class RideDetailPresenter {
    
    private var detailView :RideDetailView?
    private let dataManager = DataManager()
    
    func attachView(view:RideDetailView) {
        detailView = view
    }
    
    func detachView() {
        detailView = nil
    }
    
    func postRequest(methodName: String, imgData: Data?) {
        
        let rideData = detailView?.getRideData()
        
        var rideType = ""
        if let type = rideData?.rideType {
            rideType = type.rawValue
        }
        
        detailView?.startLoading()
        
        let param: [String:Any] = ["method":methodName,
                                   "user_id" : UserDefaults.standard.getUserID(),
                                   "ride_id" :  rideData?.rideID ?? "",
                                   "ride_name" :  rideData?.rideName ?? "New Ride",
                                   "ride_desc" : rideData?.rideDesc ?? "No Desc",
                                   "ride_date_from" : rideData?.startDate ?? "",
                                   "ride_time_from" : rideData?.startTime ?? "",
                                   "ride_date_to" : rideData?.endDate ?? "",
                                   "ride_time_to" : rideData?.endTime ?? "",
                                   "ride_participant_limit" : rideData?.maxRider ?? "0",
                                   "ride_type": rideType
                                ]

        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {

            dataManager.getDataWithImage(requestType: "POST", url: url, _params: param, imgData: imgData) { (data, error) in

                if error == nil {

                    let jsonDecoder = JSONDecoder()

                    do {
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        self.parseNewRideResponse(data: responseModel)
                    }
                    catch {
                    }
                }
                else {
                     self.detailView?.showMessage(message: CustomError.BadRequest, title: "Error", reCall: false)
                }
                    self.detailView?.stopLoading()
            }
        }
    }

  private func parseNewRideResponse(data: BaseModel) {
        
        detailView?.stopLoading()
        
        if data.status == Constant.kSuccess {
            
            if data.content?.result_set?.count == 1 {
                
                if let list = data.content?.result_set {
                    let rideData: Result_set = list[0]
                    
                    self.detailView?.showMessage(message: CustomError.Success, title: "Success", reCall: false)
                    self.detailView?.updateRideID(rideID: rideData.ride_id!)
                }
            }
        }
        else {
            self.detailView?.showMessage(message: CustomError.DatabaseError, title: "Failure", reCall: false)
        }
    }
}
