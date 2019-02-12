//
//  WayPointVC.swift
//  weRide
//
//  Created by Ashok Gupta on 24/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol WayPointView: BaseView {
    func getList() -> (waypoints: [Waypoints], tempDeleted:[Waypoints])
    func updatePath(responseData: GoogleMapBase)
    func showMessage(message: CustomError, title: String, reCall: Bool)
    func updateList(resultList: [Result_set], with action: String)
}

class WayPointVC: BaseVC, UINavigationBarDelegate, CLLocationManagerDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var tblWayPoints: UITableView!
    @IBOutlet weak var mapView: GMSMapView!
    
    //MARK:- Member Variables
    var presenter: WayPointPresenter = WayPointPresenter()
    var locationManager = CLLocationManager()
    // var tappedMarker = GMSMarker()
    //  var infoWindow = MarkerInfoWindow(frame: CGRect(x: 0, y: 0, width: 150, height: 80))
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var wayPointList:[Waypoints] = []
    var deletedIndex: Int = 0
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tblWayPoints.registerCellNib(WayPointCell.self)
        tblWayPoints.rowHeight = UITableViewAutomaticDimension
        tblWayPoints.estimatedRowHeight = 160
        
        mapView.mapType = .normal
        
        let tripTab = self.tabBarController as! TripTabVC
        if let points = tripTab.responseData?.waypoints {
            wayPointList = points
        }
        else {
            self.tblWayPoints.isHidden = true
        }
        
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tripTab = self.tabBarController as! TripTabVC
        
        if #available(iOS 11.0, *) {
            tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        tabBarController?.navigationItem.title = "Way Points"
        tabBarController?.navigationItem.rightBarButtonItems = nil
        
        let detail = UIBarButtonItem(image: #imageLiteral(resourceName: "tripdetails_selected"), style: .done, target: self, action: #selector(btnDetailTapped))
        let search = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .done, target: self, action: #selector(btnSearchTapped))
        
        if tripTab.screenFor == .ADD || tripTab.participantType == .OWNER {
            //            let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(btnSaveTapped))
            tabBarController?.navigationItem.setRightBarButtonItems([detail, search], animated: true)
        }
        else {
            tabBarController?.navigationItem.setRightBarButton(detail, animated: true)
        }
        
        DispatchQueue.main.async {
            if self.wayPointList.count == 0 {
                self.tblWayPoints.isHidden = true
            }
            else {
                self.tblWayPoints.isHidden = false
            }
            
            if self.wayPointList.count == 1 {
                self.drawMarker(placeData: self.wayPointList.first!, title: "1")
            }
            else if self.wayPointList.count > 1 {
                self.presenter.getDirection(list: self.wayPointList)
            }
            self.tblWayPoints.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationItem.searchController = nil
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Events
    @objc func btnSaveTapped() { }
    
    @objc func btnDetailTapped() {
        let detailVC = Utils.tripStoryboardController(identifier: Constant.kWayPointListing_VC) as! WayPointListingVC
        detailVC.list = wayPointList
        detailVC.delegate = self
        self.navigationItem.title = ""
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        tabBarController?.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func btnSearchTapped() {
        addSearchContainer()
    }
    
    //MARK:- Member Functions
    func addSearchContainer() {
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.sizeToFit()
        
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
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
    
    func drawMarker(placeData: Waypoints, title: String) {
        
        guard  let coordinate = createCoordinate(strLat: placeData.waypoint_latitude, strLon: placeData.waypoint_longitude) else {
            return
        }
        
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 10.0)
        mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = title
        marker.snippet = placeData.waypoint_location_name
        marker.map = mapView
    }
    
    func drawPath(path: GMSPath?) {
        
        mapView.clear()
        var index: Int = 1
        for waypoint in wayPointList {
            drawMarker(placeData: waypoint, title: String(index))
            index = index + 1
        }
        
        if let _path = path {
            let route = GMSPolyline(path: _path)
            if #available(iOS 11.0, *) {
                route.strokeColor = UIColor(named: "BaseColor")!
            } else {
                // Fallback on earlier versions
            }
            route.strokeWidth = 5.0
            route.map = mapView
        }
    }
}

//MARK:- GMSAutocompleteResultsViewControllerDelegate
extension WayPointVC: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        //          print("Place name: \(place.name)")
        //          print("Place address: \(place.formattedAddress)")
        //          print("Place attributions: \(place.attributions)")
        
        var wayPointData = Waypoints()
        wayPointData.waypoint_location_name = place.name
        wayPointData.waypoint_latitude = place.coordinate.latitude.description
        wayPointData.waypoint_longitude = place.coordinate.longitude.description
        wayPointData.coordinate = place.coordinate
        
        let tripTab = self.tabBarController as! TripTabVC
        if let rideID = tripTab.rideData.rideID {
            presenter.saveWayPoints(rideID: rideID, data: wayPointData, action: "I")
        }
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension WayPointVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wayPointList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WayPointCell.identifier) as! WayPointCell
        
        let data = wayPointList[indexPath.row]
        cell.lblSrNo.text = String(indexPath.row + 1)
        cell.lblName.text = data.waypoint_location_name
        cell.btnDelete.tag = indexPath.row
        cell.delegate = self
        
        let tripTab = self.tabBarController as! TripTabVC
        if tripTab.participantType! == .OWNER {
            cell.btnDelete.isHidden = false
        }
        else {
            cell.btnDelete.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK:- WayPointCellDelegate
extension WayPointVC : WayPointCellDelegate {
    func btnDeleteTapped(sender: UIButton) {
        deletedIndex = sender.tag
        
        let tripTab = self.tabBarController as! TripTabVC
        if let rideID = tripTab.rideData.rideID {
            presenter.saveWayPoints(rideID: rideID, data: wayPointList[deletedIndex], action: "D")
        }
    }
    
    func btnCellTapped(sender: UIButton) { }
}

//MARK:- WayPointView
extension WayPointVC : WayPointView {
    func updateList(resultList: [Result_set], with action: String) {
        if action == "I" {
            for result in resultList {
                var newObj = Waypoints()
                newObj.way_point_id = result.way_point_id
                newObj.waypoint_location_name = result.waypoint_location_name
                newObj.waypoint_latitude = result.waypoint_latitude
                newObj.waypoint_longitude = result.waypoint_longitude
                
                wayPointList.append(newObj)
            }
        }
        else {
            wayPointList.remove(at: deletedIndex)
        }
        
        DispatchQueue.main.async {
            self.tblWayPoints.reloadData()
            
            if  self.wayPointList.count > 0 {
                self.tblWayPoints.isHidden = false
            }
            else {
                self.tblWayPoints.isHidden = true
            }
            
            if self.wayPointList.count > 1 {
                self.presenter.getDirection(list: self.wayPointList)
            }
            else if self.wayPointList.count == 1 || self.wayPointList.count == 0 {
                self.drawPath(path: nil)
            }
            
            if self.wayPointList.count > 0 {
                self.tblWayPoints.scrollToRow(at: IndexPath(row: self.wayPointList.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    func updateList(resultList: [Result_set]) { }
    
    func showMessage(message: CustomError, title: String, reCall: Bool) {
        alertError(parent: self, error: message, title: title) {
        }
    }
    
    func updatePath(responseData: GoogleMapBase) {
        
        if let routes = responseData.routes {
            if let polyPath = routes.last?.overview_polyline?.points {
                if let decodedPath = GMSPath(fromEncodedPath: polyPath) {
                    DispatchQueue.main.async {
                        self.drawPath(path: decodedPath)
                    }
                }
            }
        }
    }
    
    func getList() -> (waypoints: [Waypoints], tempDeleted: [Waypoints]) {
        return (wayPointList, [])
    }
}

//MARK:- WayPointListingVCDelegate
extension WayPointVC : WayPointListingVCDelegate {
    func didMovedToParentController() {
        if #available(iOS 11.0, *) {
            tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
}
