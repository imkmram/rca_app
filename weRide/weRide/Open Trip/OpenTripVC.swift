//
//  OpenTripVC.swift
//  weRide
//
//  Created by Ashok Gupta on 24/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class OpenTripVC: BaseVC {

    @IBOutlet weak var tblTrip: UITableView!
    
    var openTripList:[Result_set] = []
    var selectedTrip: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblTrip.registerCellNib(TripCell.self)
        tblTrip.rowHeight = UITableViewAutomaticDimension
        tblTrip.estimatedRowHeight = 160
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
         self.tabBarController?.navigationItem.setRightBarButton(nil, animated: true)
        
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        self.tabBarController?.navigationItem.title = "Open Rides"
        
        if UserDefaults.standard.isLoggedIn() {
            getOpenRides()
        }
    }
    
    func getOpenRides() {
        
        startLoading()
        
        let dataManager = DataManager()
        
        let param: [String:Any] = ["method":Constant.kOpenRides,
                                   "user_id" : UserDefaults.standard.getUserID()
        ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        self.parseMyRidesResponse(data: responseModel)
                    }
                    catch {
                    }
                }
                else {
                    
                    self.alertError(parent: self, error: CustomError.BadRequest, title: "Error", handler: {
                    })
                }
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
        }
    }
    
    func parseMyRidesResponse(data: BaseModel) {
        
        DispatchQueue.main.async {
            
            if (data.content?.result_set?.count)! > 0 {
                
                if let list = data.content?.result_set {
                    
//                    let newList = list.filter({ (tripData) -> Bool in
//                        tripData.owner_id != UserDefaults.standard.getUserID()
//
//                    })
                    
                    self.openTripList = list
                    self.tblTrip.reloadData()
                }
            }
        }
    }
    
    func presentActionSheet() {
        
        let data = openTripList[selectedTrip]
        
        let actionSheetVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
         let joinAction = UIAlertAction(title: "Join", style: .default, handler: nil)

        let viewAction = UIAlertAction(title: "View", style: .default){ (action) in
            let tripTab = Utils.tripStoryboardController(identifier: Constant.kTRIPTAB_VC) as! TripTabVC
            tripTab.screenFor = Screen.VIEW
            tripTab.responseData = data
            tripTab.participantType = ParticipantType.CO_RIDER
            let rootController =  self.tabBarController?.navigationController
            rootController?.pushViewController(tripTab, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetVC.addAction(joinAction)
        actionSheetVC.addAction(viewAction)
        actionSheetVC.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(actionSheetVC, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension OpenTripVC : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return  openTripList.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: TripCell.identifier) as! TripCell
        cell.setData(openTripList[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTrip = indexPath.row
        presentActionSheet()
    }
}
