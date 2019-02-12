//
//  VehicleVC.swift
//  weRide
//
//  Created by Ashok Gupta on 03/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class ManageVehicleVC: BaseVC {

    @IBOutlet weak var tblVehicleList: UITableView!
    
    var vehicleList:[Result_set] = []
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblVehicleList.registerCellNib(VehicleCell.self)
        tblVehicleList.rowHeight = UITableViewAutomaticDimension
        tblVehicleList.estimatedRowHeight = 160
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Manage Vehicles"
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(btnAddTapped))
        
        self.navigationItem.setRightBarButtonItems([add], animated: true)
        
        getVehicleList()
    }
    
    func getVehicleList() {
        
        startLoading()
        
        let dataManager = DataManager()
    
        let param: [String:Any] = ["method" : Constant.kGetVehicle,
                                   "user_id" : UserDefaults.standard.getUserID(),
        ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
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
                    
                    self.alertError(parent: self, error: CustomError.BadRequest, title: "Error", handler: {
                    })
                }
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
        }
    }
    
    func parseResponse(data: BaseModel) {
        
        self.stopLoading()
        
        if data.status == Constant.kSuccess {
            
            guard let value = data.content?.result_set else {
                return
            }
            
            DispatchQueue.main.async {
                self.vehicleList = value
                self.tblVehicleList.reloadData()
            }
        }
        else {
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func btnAddTapped() {
        
//        let addVehicle = Utils.profileStoryboardController(identifier: Constant.kAddVehicle_VC) as! AddVehicleVC
//        addVehicle.delegate = self
//        addVehicle.action = ActionType.New
//        addVehicle.modalPresentationStyle = .overCurrentContext
//        self.present(addVehicle, animated: true, completion: nil)
        
        let addVehicle = Utils.profileStoryboardController(identifier: Constant.kAddNewVehicle_VC) as! AddNewVehicleVC
        navigationItem.title = ""
        addVehicle.action = ActionType.New
        addVehicle.delegate = self
        
        navigationController?.pushViewController(addVehicle, animated: true)
    }
    
    func deleteVehicle() {
        startLoading()
        
        let dataManager = DataManager()
         let data = self.vehicleList[self.selectedIndex]
        
        let param: [String:Any] = ["method" : Constant.kDeleteVehicle,
                                   "vehicle_id" : data.vehicle_id!
                                   ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        if responseModel.status == Constant.kSuccess {
                            self.alertError(parent: self, error: CustomError.Delete, title: "Success", handler: {
                                self.updateList()
                            })
                        }
                    }
                    catch {
                        
                        print("TRY BEEN CAUGHT")
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
    
    func presentActionSheet() {
        
        let actionSheetVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete Vehicle", style: .destructive){ (action) in
            
            self.deleteVehicle()
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .default){ (action) in
            
             let data = self.vehicleList[self.selectedIndex]
            let addVehicle = Utils.profileStoryboardController(identifier: Constant.kAddNewVehicle_VC) as! AddNewVehicleVC
            addVehicle.delegate = self
            addVehicle.vehicleData = data
            addVehicle.action = ActionType.Edit
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(addVehicle, animated: true)
            
            //addVehicle.modalPresentationStyle = .overCurrentContext
           // self.present(addVehicle, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetVC.addAction(deleteAction)
        actionSheetVC.addAction(editAction)
        actionSheetVC.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(actionSheetVC, animated: true, completion: nil)
        }
    }
}

extension ManageVehicleVC : AddVehicleVCDelegate, AddNewVehicleVCDelegate {
    func updateList() {
        getVehicleList()
    }
}

extension ManageVehicleVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vehicleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.identifier) as! VehicleCell
        let data = vehicleList[indexPath.row]
        cell.setData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        presentActionSheet()
    }
}
