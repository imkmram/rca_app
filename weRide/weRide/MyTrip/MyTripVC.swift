//
//  MyTripVC.swift
//  weRide
//
//  Created by Ashok Gupta on 24/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

protocol GeneralView: BaseView {
    func updateList()
    func setList(list:[Result_set])
    func showMessage(message: CustomError, title: String, reCall: Bool)
}

class MyTripVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet weak var tblTrip: UITableView!
    
    //MARK:- Member Variables
    var myTripList:[Result_set] = []
    var selectedIndex: Int = 0
    private var presenter = MyTripPresenter()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblTrip.registerCellNib(TripCell.self)
        tblTrip.rowHeight = UITableViewAutomaticDimension
        tblTrip.estimatedRowHeight = 160
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //          self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor(named: "BaseColor")
        //        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(named: "BaseColor") as Any]
        //
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddTapped))
        self.tabBarController?.navigationItem.setRightBarButton(add, animated: true)
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        self.tabBarController?.navigationItem.title = "My Rides"
        
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationController?.navigationBar.barTintColor = UIColor(named: "BaseColor")
        } else {
            // Fallback on earlier versions
        }
        
        if UserDefaults.standard.isLoggedIn() {
            presenter.getMyRides()
        }
    }
    
    //MARK:- Events
    @objc func btnAddTapped() {
        
        let tripTab = Utils.tripStoryboardController(identifier: Constant.kTRIPTAB_VC) as! TripTabVC
        tripTab.screenFor = Screen.ADD
        tripTab.action = ActionType.New
        let rootController = self.tabBarController?.navigationController
        rootController?.pushViewController(tripTab, animated: true)
    }
    
    func presentActionSheet() {
        
        let data = myTripList[selectedIndex]
        
        let actionSheetVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete Ride", style: .destructive){ (action) in
            self.presenter.deleteRide(data: data)
        }
        
        let viewAction = UIAlertAction(title: "View", style: .default){ (action) in
            let tripTab = Utils.tripStoryboardController(identifier: Constant.kTRIPTAB_VC) as! TripTabVC
            tripTab.screenFor = Screen.VIEW
            tripTab.responseData = data
            tripTab.action = ActionType.Edit
            tripTab.participantType = ParticipantType.CO_RIDER
            let rootController =  self.navigationController?.tabBarController?.navigationController
            rootController?.pushViewController(tripTab, animated: true)
        }
        
        let startAction = UIAlertAction(title: "Start Ride", style: .default) { (action) in
            
//            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//                UIApplication.shared.openURL(URL(string:
//                    "comgooglemaps://?center=40.765819,-73.975866&zoom=14&views=traffic")!)
//            } else {
//                print("Can't use comgooglemaps://");
////                let strURL = "https://www.google.com/maps/dir/?api=1&origin=19.021324,72.8424178&destination=19.2812547,73.0482912&waypoints=19.2461644,72.8509056%7C19.3666371,72.8160976"
//
//                guard let points = data.waypoints else {
//                    return
//                }
//
//                if points.count > 0 {
//                    let strURL = Utils.googleMapURL(callType: GOOGLE_CallType.DIRECTION, list: points)
//                    let url = URL(string: strURL)
//
//                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
//                }
//                else {
//                    self.alertError(parent: self, error: CustomError.NoRoutes, title: "Message", handler: {
//
//                    })
//                }
//            }
            
                        let startRideVC = Utils.startRideStoryboardController(identifier: Constant.kStartRide_VC) as! StartRideVC
            
                        if let list = data.waypoints {
                               startRideVC.waypointList = list
                        }
                        self.tabBarController?.navigationController?.navigationBar.isHidden = true
            if #available(iOS 11.0, *) {
                self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
            } else {
                // Fallback on earlier versions
            }
                        self.tabBarController?.navigationController?.pushViewController(startRideVC, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetVC.addAction(deleteAction)
        actionSheetVC.addAction(startAction)
        actionSheetVC.addAction(viewAction)
        actionSheetVC.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(actionSheetVC, animated: true, completion: nil)
        }
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension MyTripVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTripList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TripCell.identifier) as! TripCell
        cell.setData(myTripList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        presentActionSheet()
    }
}

//MARK:- CommonView
extension MyTripVC : GeneralView {
    func updateList() {
        presenter.getMyRides()
    }
    
    func setList(list: [Result_set]) {
        DispatchQueue.main.async {
            self.myTripList = list
            self.tblTrip.reloadData()
        }
    }
    
    func showMessage(message: CustomError, title: String, reCall: Bool) {
        self.alertError(parent: self, error: message, title: title, handler: {
            if reCall {
                self.updateList()
            }
        })
    }
}
