//
//  ViewController.swift
//  WeRide
//
//  Created by Ashok Gupta on 21/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, UINavigationBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    
        // mapView = GMSMapView(frame: view.frame)
        //        mapView.settings.compassButton = true
        //        mapView.isMyLocationEnabled = true
        //        mapView.settings.myLocationButton = true
        //  mapView.delegate = self
        //view.addSubview(mapView)
        
        // let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        // let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        // view = mapView
        
        // Creates a marker in the center of the map.
        //        let marker = GMSMarker()
        //        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        //        marker.title = "Sydney"
        //        marker.snippet = "Australia"
        //        marker.map = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.first
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, zoom: 15);
        self.mapView.camera = camera
        self.mapView.isMyLocationEnabled = true
        
        let marker = GMSMarker(position: center)
        print("Latitude :- \(userLocation!.coordinate.latitude)")
        print("Longitude :-\(userLocation!.coordinate.longitude)")
        marker.map = self.mapView
        
        marker.title = "Current Location"
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
}

extension ViewController : GMSMapViewDelegate {
    
}
