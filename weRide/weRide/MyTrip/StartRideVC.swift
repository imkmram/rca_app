//
//  StartRideVC.swift
//  weRide
//
//  Created by Ashok Gupta on 17/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit
import GoogleMaps

//MARK:- StartRideView Declaration
protocol RideView: BaseView {
    func updatePath(responseData: GoogleMapBase)
    func showMessage(message: CustomError, title: String, reCall: Bool)
}

class StartRideVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet weak var mapView: GMSMapView!
    
    //MARK:- Member Variables
    var waypointList:[Waypoints] = []
    let presenter: StartRidePresenter = StartRidePresenter()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Map"
        
        if waypointList.count > 0 {
            presenter.getDirection(list: waypointList)
        }
        else {
            self.alertError(parent: self, error: CustomError.NoRoutes, title: "Message", handler: {
                
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Member Function
    func drawPath(path: GMSPath) {
        
        var index: Int = 0
        for waypoint in waypointList {
            zoomCamera(placeData: waypoint, title:String(index + 1))
            index = index + 1
        }
        
        let route = GMSPolyline(path: path)
        if #available(iOS 11.0, *) {
            route.strokeColor = UIColor(named: "BaseColor")!
        } else {
            // Fallback on earlier versions
        }
        route.strokeWidth = 5.0
        route.map = mapView
    }
    
    func zoomCamera(placeData: Waypoints, title: String) {
        
        guard  let coordinate = createCoordinate(strLat: placeData.waypoint_latitude, strLon: placeData.waypoint_longitude) else {
            return
        }
        
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 12.0)
        mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = title
        marker.snippet = placeData.waypoint_location_name
        marker.map = mapView
    }
    
    func createCoordinate(strLat: String?, strLon: String?) -> CLLocationCoordinate2D? {
        
        guard let latPoint = strLat, let logPoint = strLon else {
            return nil
        }
        
        guard  let lat = Double(latPoint), let log = Double(logPoint) else {
            return nil
        }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: log)
    }
}

//MARK:- StartRideView Implementation
extension StartRideVC : RideView {
    func showMessage(message: CustomError, title: String, reCall: Bool) {
        alertError(parent: self, error: message, title: title) {
        }
    }
    
    func updatePath(responseData: GoogleMapBase) {
        if let routes = responseData.routes {
            if let polyPath = routes.last?.overview_polyline?.points, let decodedPath = GMSPath(fromEncodedPath: polyPath) {
                
                DispatchQueue.main.async {
                    self.drawPath(path: decodedPath)
                }
            }
        }
    }
}

extension StartRideVC : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        guard  let tag = Int(marker.title!) else {
            return
        }

        let obj = waypointList[tag - 1]
        
        let mediaVC = Utils.startRideStoryboardController(identifier: Constant.kMediaContent_VC) as! MediaContentVC
        mediaVC.wayPointData = obj
        
        self.navigationController?.pushViewController(mediaVC, animated: true)
    }
}
