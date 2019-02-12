//
//  WayPointPresenter.swift
//  weRide
//
//  Created by Ashok Gupta on 17/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation
import GoogleMaps

class WayPointPresenter {
    
    private var wayPointView :WayPointView?
    private var dataManager:DataManager = DataManager()
    
    func attachView(view: WayPointView) {
        wayPointView = view
    }
    
    func detachView() {
        wayPointView = nil
    }
    
    private func newCreateDictionary(data: Waypoints, action: String) -> [[String:Any]] {
        var dictArray: [[String:Any]] = []
        
        if action == "I" {
                var dict:[String:Any] = [:]
                dict["location"] = data.waypoint_location_name
                dict["latitude"] = data.waypoint_latitude
                dict["longitude"] = data.waypoint_longitude
                dict["action"] = "I"
                
                dictArray.append(dict)
        }
        else {
            var dict:[String:Any] = [:]
            dict["waypoint_id"] = data.way_point_id
            dict["action"] = "D"
            
            dictArray.append(dict)
        }
        
        return dictArray
    }
    
    func saveWayPoints(rideID: String!, data: Waypoints, action: String) {
        wayPointView?.startLoading()
        
        let waypointArray:[[String:Any]] = newCreateDictionary(data: data, action: action)
        
        var strJSON: String = ""
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: waypointArray,
            options: []
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.utf8) {
            print("JSON string = \n\(theJSONText)")
            
            strJSON = theJSONText
        }
        let param: [String:Any] = ["method" : Constant.kAddWayPoints,
                                   "ride_id" : rideID,
                                   "waypoints" : strJSON
        ]
        //        do {
        //            let json = try! JSONSerialization.jsonObject(with: JSONSerialization.data(withJSONObject: param, options: []), options: [])
        //            print(json)
        //        }
        //
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                  
                    if action == "I" {
                        let jsonDecoder = JSONDecoder()
                        
                        do {
                            let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                            self.parseResponse(data: responseModel, action: action)
                        }
                        catch {
                            print("TRY BEEN CAUGHET")
                        }
                    }
                    else {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                            print(json)
                            
                            if json["status"] as! String == Constant.kSuccess {
                                self.wayPointView?.updateList(resultList: [], with: action)
                            }
                            else {
                                 self.wayPointView?.showMessage(message: CustomError.DatabaseError, title: "Message", reCall: false)
                            }
                        }
                        catch {
                            print("Caught")
                        }
                    }
                }
                else {
                    //                    self.alertError(parent: self, error: CustomError.BadRequest, title: "Error", handler: {
                    //                    })
                }
                self.wayPointView?.stopLoading()
            }
        }
    }
    
    private func parseResponse(data: BaseModel, action: String) {
        
        self.wayPointView?.stopLoading()
        
        DispatchQueue.main.async {
            if data.status == Constant.kSuccess {
                
               // self.tempDeletedList.removeAll()
            
                guard let returnedList = data.content?.result_set else {
                    return
                }
                self.wayPointView?.updateList(resultList: returnedList, with: action)
            }
            else {
                  self.wayPointView?.showMessage(message: CustomError.DatabaseError, title: "Message", reCall: false)
            }
        }
    }
    
    func getDirection(list:[Waypoints]) {
       
        let str = Utils.googleMapURL(callType: GOOGLE_CallType.ROUTE, list: list)
        
        if let url = URL(string: str) {
            
            dataManager.requestGET(requestType: "GET", url: url) { (data, error) in
                
                if error == nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                    }
                    catch {
                        print("Caught")
                    }
                    let jsonDecoder = JSONDecoder()

                    do {
                        let responseModel = try jsonDecoder.decode(GoogleMapBase.self, from: data!)
                        self.parseGoogleResponse(data: responseModel)
                    }
                    catch {
                        print("TRY BEEN CAUGHET")
                    }
                }
                else {
                    self.wayPointView?.showMessage(message: CustomError.BadRequest, title: "Error", reCall: false)
                }
                self.wayPointView?.stopLoading()
            }
        }
    }
    
  private  func parseGoogleResponse(data: GoogleMapBase) {
         wayPointView?.updatePath(responseData: data)
    }
}
