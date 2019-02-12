//
//  StartRidePresenter.swift
//  weRide
//
//  Created by Ashok Gupta on 17/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import Foundation
import GoogleMaps

class StartRidePresenter {
    
    private var rideView :RideView?
    private var dataManager:DataManager = DataManager()
    
    func attachView(view:RideView) {
        rideView = view
    }
    
    func detachView() {
        rideView = nil
    }
    
//    func getRoute(waypoints: [Waypoints]) {
//
//        let strURL: String = createURL(list: waypoints)
//
//        if let url = URL(string: "https"){
//
//            dataManager.getData(requestType: "GET", url: url, parameter: nil) { (data, error) in
//
//            }
//        }
//    }
    
//    func getPolyPath() {
//
//        let polyPath = "k`bsB}_r{LAfAQNK@kAm@q@a@a@QUAeA?]Bc@Fa@NWVa@l@cAfBMP]ZaB~@oB|@OJSVQFi@n@?g@Ee@GSaB_@{L_BaBSeEk@{C_@}Fu@{D[_CIsEIiCK{BIu@?iFNiEb@}ATiBZkBf@{Af@oClAsFxBeDdA_JdDwF~BsAd@u@Rg@Fk@D{@@iDAmB?iFL[@K?MAI?IY{@cDkAoDCSIsAwAmE{B_IiAkEq@qBQi@Ua@_@g@y@y@uBkAgC}@g@Mm@EqAKmAAqLFiEIgNCaCAuPCoWOaKEeLM_KEgLGsOIqD@U@cUhCiC`@cAVaA`@uAx@k@b@cGfFs@`@mAd@uB`@eAF{@?}@Gy@MqA]u@[iAu@w@s@eAoAg@aAa@qAWuA_@aD{AeN_@kBk@qBc@{@{@yA[e@{@{@qAeAaAk@eAg@gAg@y@UcDu@aBa@_KmCmAa@cAOaA[mCu@c@G}@GgB@{ANmAN}Er@uLvAyCb@cBRyBEw@GwEm@qWaDmBYaD[aKy@qCSyC[{I_AqJmAiL_Bm@E_A@iAFeAPkBp@gExB}@VaAP{AJ_IBiYRmLRgIVsHFmKRyBAqAKgB[uEeAyCs@yE{@iBOuGYiIYwDI_E[gKa@uEOoDW{BUoCSqIu@sE[{Ku@e@K{@IsM_AsKy@qSkAuIa@_G]eJi@eCKk@?eA@yAJcFx@cD~@_Cf@u@H_CDqIDwBAsA@}V?oRD{DBuJAm@Em@OmAg@mBcAkBaAgBs@eBq@q@OuReCeKcAeEe@uBa@m@QiAa@kAk@}@q@mBiBiCuC{FsFwCkCiAuA_@e@[UiAy@eD_D{AgAkCwAeBm@_AUqB]gAK}CIaCDkA@y@F{ARgCh@iBb@}Cv@uFxAcKdCmA\\iKdCaFlAsHdBmLzCcHnBmALy@DwC?kS?yN?aLNoDWgAIqK}@uLkAeBKsMeAyPgAqASkAYcBg@o@Ww@g@oEaDaBcAmIkF{L}G}EuCgBiA}BwAmAg@oBy@kE_BkWwIyEwBwEmDcFwDiEwCi@|@i@t@[XYRc@Pc@FgAC}@Eg@Ke@IsHUaDOU@}H]eCLYAe@OeAg@{BqAiFmCcGmD{DqBuE~GcBfCoA|BuBzCkCzDwBjDcFpHuFrIwEdHaHfKsE~GsAvAaFdFoIhIaK~JyIlJcAfAABAHOFMCORSXsAnA_E~DgEzDcDnDSFYKEC[YsBiCm@w@wBqCu@eAw@eAYS]MsB_@cAY_EoA_@Oa@_@uAgB{AeCkCb@a@F"
//
//        print(polyPath)
//
//        let decodedPath = GMSPath(fromEncodedPath: polyPath)
//
//        //print(decodedPath)
//
//        rideView?.updateMap(path: decodedPath)
//    }
//
//    private func createURL(list: [Waypoints]) -> String {
//
//        let baseURL = "https://maps.googleapis.com/maps/api/directions/json?"
//
//        //https://maps.googleapis.com/maps/api/directions/json?origin=Boston,MA&destination=Concord,MA&waypoints=Charlestown,MA|Lexington,MA&key=YOUR_API_KEY
//
//        var origin: String = "origin="
//        var destination: String = "&destination="
//        var waypoints: String = "&waypoints="
//        let key: String = "&key=AIzaSyCVYea3FADPjTTU5jHGT-NANukCl-RxAuY"
//
//        if list.count > 1 && list.count == 2 {
//
//            let startLocation = list.first
//            let endLocation = list.last
//
//            origin = origin.appending("\(startLocation?.waypoint_latitude ?? ""),\(startLocation?.waypoint_longitude ?? "")")
//
//             destination = destination.appending("\(endLocation?.waypoint_latitude ?? ""),\(endLocation?.waypoint_longitude ?? "")")
//
//            let strURL = baseURL.appending(origin).appending(destination).appending(key)
//
//            return strURL
//
//        }
//        else if list.count > 2 {
//
//            let startLocation = list.first
//            let endLocation = list.last
//
//            origin = origin.appending(startLocation?.waypoint_location_name ?? "")
//            destination = destination.appending(endLocation?.waypoint_location_name ?? "")
//
//            for index in 0..<list.count - 2 {
//
//                let location = list[index]
//
//                waypoints = waypoints.appending("via:\(String(describing: location.waypoint_location_name))|")
//            }
//            waypoints = String(waypoints.dropLast())
//
//            let strURL: String = baseURL.appending(origin).appending(destination).appending(waypoints).appending(key)
//            print(strURL)
//
//            return strURL
//        }
//      return ""
//    }
    
//    private func getLocation(list:[Waypoints]) -> (startLocation: Waypoints, endLocation: Waypoints, wayPointsLocation: [Waypoints]? ) {
//
//        var origin: Waypoints!
//        var destination: Waypoints!
//        var waypoints: [Waypoints]?
//
//        if list.count == 2 {
//            origin = list.first
//            destination = list.last
//        }
//        else if list.count > 2 {
//            origin = list.first
//            destination = list.last
//
//            waypoints = []
//
//            for i in 1..<list.count - 1 {
//                waypoints?.append(list[i])
//            }
//        }
//        return (origin, destination, waypoints)
//    }
    
    func getDirection(list:[Waypoints]) {
        
        var strURL: String = ""
        
//        let baseURL = Constant.kGOOGLE_BASE_URL
//        let key: String = "&key=\(Constant.kGOOGLE_KEY)"
//
//        let result = getLocation(list: list)
//
//        let origin: String = "origin=\(result.startLocation.waypoint_latitude ?? ""),\(result.startLocation.waypoint_longitude ?? "")"
//        let destination: String = "&destination=\(result.endLocation.waypoint_latitude ?? ""),\(result.endLocation.waypoint_longitude ?? "")"
//
//        if result.wayPointsLocation == nil {
//            strURL = baseURL.appending(origin).appending(destination).appending(key)
//        }
//        else {
//            var waypoints: String = "&waypoints="
//            for coordinate in result.wayPointsLocation! {
//                waypoints = waypoints.appending("\(coordinate.waypoint_latitude ?? ""),\(coordinate.waypoint_longitude ?? "")|")
//            }
//            waypoints.removeLast()
//            strURL = baseURL.appending(origin).appending(destination).appending(waypoints).appending(key)
//        }
        
        strURL = Utils.googleMapURL(callType: GOOGLE_CallType.ROUTE, list: list)
        
        if let url = URL(string: strURL) {
            
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
                    self.rideView?.showMessage(message: CustomError.BadRequest, title: "Error", reCall: false)
                }
                self.rideView?.stopLoading()
            }
        }
    }
    
    private  func parseGoogleResponse(data: GoogleMapBase) {
        rideView?.updatePath(responseData: data)
    }
    
}
