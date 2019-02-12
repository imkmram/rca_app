//
//  AddVehicleVC.swift
//  weRide
//
//  Created by Ashok Gupta on 04/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

protocol AddVehicleVCDelegate: class {
    
    func updateList()
}

enum ActionType {
    case New
    case Edit
}

class AddVehicleVC: BaseVC {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var segmentVehicleType: UISegmentedControl!
    @IBOutlet weak var txtModel: UITextField!
    @IBOutlet weak var txtMake: UITextField!
    @IBOutlet weak var txtRegNo: UITextField!
    
    weak var delegate: AddVehicleVCDelegate?
    
    var vehicleType: VehicleType!
    var action: ActionType!
    var vehicleData: Result_set?
    private var vehicleID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.layer.cornerRadius = 10.0
        segmentVehicleType.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        
        if action == ActionType.New {
            segmentVehicleType.selectedSegmentIndex = 0
            vehicleType = VehicleType.Car
            lblTitle.text = "Add New Vehicle"
        }
        else {
            lblTitle.text = "Edit Vehicle"
            
            if let data = vehicleData {
                vehicleID = data.vehicle_id
                txtRegNo.text = data.registration_no
                txtMake.text = data.manufacturer
                //txtModel.text = data.model
                
                if data.vehicle_type == "Car" {
                    segmentVehicleType.selectedSegmentIndex = 0
                    vehicleType = VehicleType.Car
                }
                else if data.vehicle_type == "Bike" {
                     segmentVehicleType.selectedSegmentIndex = 1
                    vehicleType = VehicleType.Bike
                }
                else {
                     segmentVehicleType.selectedSegmentIndex = 2
                    vehicleType = VehicleType.Other
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func valueChanged(sender: UISegmentedControl) {
    
        switch sender.selectedSegmentIndex {
        case 0:
            vehicleType = VehicleType.Car
        case 1:
            vehicleType = VehicleType.Bike
        case 2:
            vehicleType = VehicleType.Other
        default:
            break
        }
    }
    
    @IBAction func btnSaveTapped(_ sender: UIBarButtonItem) {
        saveVehicleData()
    }
    
    @IBAction func btnCloseTapped(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveVehicleData() {
        
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
                                   "vehicle_id" : vehicleID ?? "",
                                   "vehicle_type" : vehicleType.rawValue,
                                   "registration_no" : txtRegNo.text ?? "",
                                   "manufacturer" : txtMake.text ?? "",
                                   "model" : txtModel.text ?? ""
        ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    
                    do {
                        let json: [String:Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
                        print(json)
                        let status = json["status"] as! String
                        
                        if status == Constant.kSuccess {
                            self.dismiss(animated: true, completion: {
                                self.delegate?.updateList()
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
            
          //  DispatchQueue.main.async {
                
                self.alertError(parent: self, error: CustomError.Success, title: "Success", handler: {
                    
                    self.dismiss(animated: true, completion: {
                         self.delegate?.updateList()
                    })
                })
               
           // }
        }
        else {
            
        }
    }
}
