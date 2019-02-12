//
//  AddNewVehicleVC.swift
//  weRide
//
//  Created by Ashok Gupta on 11/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

protocol AddNewVehicleVCDelegate: class {
    func updateList()
}

class AddNewVehicleVC: BaseVC {
    
    //MASRK:- Outlet
    @IBOutlet weak var tblVehicle: UITableView!
   
    
    //MARK:- Member Variable
    var model = VehicleModel()
    var action:ActionType!
    var vehicleData: Result_set?
    weak var delegate: AddNewVehicleVCDelegate?

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblVehicle.registerCellNib(VehicleDetailCell.self)
        tblVehicle.registerCellNib(InsuranceCell.self)
        tblVehicle.rowHeight = UITableViewAutomaticDimension
        tblVehicle.estimatedRowHeight = 160
        
        if action! == .Edit {
            if let data = vehicleData {
                model.vehicleID = data.vehicle_id
                model.Make = data.manufacturer
                model.MakeYear = data.year
                model.Color = data.color
                model.ChassisNumber = data.chassis_no
                model.EngineCapacity = data.engine_capacity
                model.RegNo = data.registration_no
                
                if data.vehicle_type == "Car" {
                    model.type = VehicleType.Car
                }
                else if data.vehicle_type == "Bike" {
                    model.type = VehicleType.Bike
                }
                else {
                    model.type = VehicleType.Other
                }
                
                model.insurer = data.insurer
                model.expiryDate = data.expiry
                model.insuredAmt = data.insured_sum
            }
        }
        else {
            model.type = VehicleType.Car
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Add Vehicle"
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(btnSaveTapped))
        self.navigationItem.setRightBarButtonItems([save], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Event
    @objc func btnSaveTapped() {
        saveData()
    }
    
    //MARK:- Member Function
    func saveData() {
        
        startLoading()
        
        let dataManager = DataManager()
        
        var methodName: String = ""
        switch action! {
        case .New:
            methodName = Constant.kAddVehicle
        case .Edit:
            methodName = Constant.kUpdateVehicle
        }
        
        let param: [String:Any] = ["method" : methodName,
                                   "user_id" : UserDefaults.standard.getUserID(),
                                   "vehicle_id" : model.vehicleID ?? "",
                                   "vehicle_type" : model.type.rawValue,
                                   "registration_no" : model.RegNo ?? "",
                                   "manufacturer" : model.Make ?? "",
                                   "year" : model.MakeYear ?? "",
                                   "colour" : model.Color ?? "",
                                   "engine_capacity" : model.EngineCapacity ?? "",
                                   "chasis_no" : model.ChassisNumber ?? "",
                                   "insurer" : model.insurer ?? "",
                                   "expiry" : model.expiryDate ?? "",
                                   "insured_sum" : model.insuredAmt ?? ""
            
                                ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    
                    do {
                        let json: [String:Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
                        print(json)
                        let status = json["status"] as! String
                        
                        if status == Constant.kSuccess {
                            self.alertError(parent: self, error: CustomError.Success, title: "Success", handler: {
                                
                                self.delegate?.updateList()
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                    }
                    catch {
                        print("Caught")
                    }
                    
                    //                    let jsonDecoder = JSONDecoder()
                    //
                    //                    do {
                    //                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                    //                        self.parseResponse(data: responseModel)
                    //                    }
                    //                    catch {
                    //
                    //                        print("TRY BEEN CAUGHET")
                    //                    }
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
            
            self.alertError(parent: self, error: CustomError.Success, title: "Success", handler: {
                
//                self.dismiss(animated: true, completion: {
//                    self.delegate?.updateList()
//                })
            })
        }
        else {
            
        }
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension AddNewVehicleVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: VehicleDetailCell.identifier) as! VehicleDetailCell
            
            cell.setData(model)
            
            return cell
        }
        else {
         
            let cell = tableView.dequeueReusableCell(withIdentifier: InsuranceCell.identifier) as! InsuranceCell
            cell.setData(model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = HeaderView.loadNib()
        view.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
    
        if section == 0 {
            view.lblTitle.text = "Vehicle Data"
        }
        else {
           view.lblTitle.text = "Insurance Data"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 50
    }
}
