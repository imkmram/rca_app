//
//  VehicleDetailCell.swift
//  weRide
//
//  Created by Ashok Gupta on 11/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class VehicleDetailCell: BaseTableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var txtChassis: UITextField!
    @IBOutlet weak var txtEngineCapacity: UITextField!
    @IBOutlet weak var txtColor: UITextField!
    @IBOutlet weak var txtMakeYear: UITextField!
    @IBOutlet weak var txtMake: UITextField!
    @IBOutlet weak var txtRegNo: UITextField!
    @IBOutlet weak var segmentVehicleType: UISegmentedControl!
    
    //MARK:- Member Variable
    var data: VehicleModel!

    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
         txtRegNo.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
         txtMake.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
         txtMakeYear.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
         txtColor.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
         txtEngineCapacity.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
          txtChassis.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
        
        
         segmentVehicleType.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
    }

    //MARK:- Event
    @objc func textChanged(sender: UITextField) {
        
        switch sender.tag {
        case 0:
            data.RegNo = sender.text
        case 1:
            data.Make = sender.text
        case 2:
            data.MakeYear = sender.text
        case 3:
            data.Color = sender.text
        case 4:
            data.EngineCapacity = sender.text
        case 5:
            data.ChassisNumber = sender.text
        default:
            break
        }
    }
    
    @objc func valueChanged(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            data.type = VehicleType.Car
        case 1:
            data.type = VehicleType.Bike
        case 2:
            data.type = VehicleType.Other
        default:
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- Set Data
    override func setData(_ data: Any?) {
        
        if let model = data as? VehicleModel {
            self.data = model
            txtRegNo.text = model.RegNo
            txtMake.text = model.Make
            txtMakeYear.text = model.MakeYear
            txtColor.text = model.Color
            txtEngineCapacity.text = model.EngineCapacity
            txtChassis.text = model.ChassisNumber
            
            switch model.type! {
            case .Car:
                segmentVehicleType.selectedSegmentIndex = 0
            case .Bike:
                segmentVehicleType.selectedSegmentIndex = 1
            case .Other:
                segmentVehicleType.selectedSegmentIndex = 2
            }
        }
    }
}
