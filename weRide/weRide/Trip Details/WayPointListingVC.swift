//
//  WayPointListingVC.swift
//  weRide
//
//  Created by Ashok Gupta on 22/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit
protocol WayPointListingVCDelegate: class {
    func didMovedToParentController()
}

class WayPointListingVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tblPlaces: UITableView!
    //MARK:- Member Variables
    weak var delegate: WayPointListingVCDelegate?
    var list:[Waypoints] = []

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblPlaces.registerCellNib(PlaceDetailCell.self)
        tblPlaces.rowHeight = UITableViewAutomaticDimension
        tblPlaces.estimatedRowHeight = 160
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        if parent == nil {
            delegate?.didMovedToParentController()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension WayPointListingVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceDetailCell.identifier) as! PlaceDetailCell
        let data = list[indexPath.row]
        cell.lblPlace.text = data.waypoint_location_name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaContentVC = Utils.startRideStoryboardController(identifier: Constant.kMediaContent_VC) as! MediaContentVC
        self.navigationItem.title = ""
        let data = list[indexPath.row]
        mediaContentVC.wayPointData = data
        self.navigationController?.pushViewController(mediaContentVC, animated: true)
    }
}
