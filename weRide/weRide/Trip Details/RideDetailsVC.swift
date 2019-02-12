//
//  RideDetails.swift
//  weRide
//
//  Created by Ashok Gupta on 25/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage

class RideDetailsVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet weak var imgRide: UIImageView!
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var vehicleType: UISegmentedControl!
    @IBOutlet weak var txtMaxRiders: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var txtRideName: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    
    //MARK:- Member Variables
    var popView: PopTipView?
    var rideMode: VehicleType!
    var startDate: String!
    var endDate: String!
    var startTime: String!
    var endTime: String!
    var selectedImage: UIImage?
    var presenter:RideDetailPresenter = RideDetailPresenter()
    let dataManager = DataManager()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//          let tripTab = self.tabBarController as! TripTabVC
        
//        if tripTab.rideData.rideType == nil {
//            vehicleType.selectedSegmentIndex = 0
//            vehicleTypeValueChanged(vehicleType)
//        }
        presenter.attachView(view: self)
        
        txtRideName.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
        txtMaxRiders.addTarget(self, action: #selector(self.textChanged(sender:)), for: UIControlEvents.editingChanged)
     
        txtDesc.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        let tripTab = self.tabBarController as! TripTabVC
        if #available(iOS 11.0, *) {
            self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.tabBarController?.navigationItem.title = tripTab.screenFor.rawValue
        self.tabBarController?.navigationItem.rightBarButtonItems = nil
        
        switch tripTab.screenFor {
        case .ADD:
            let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(btnSaveTapped))
            self.tabBarController?.navigationItem.setRightBarButton(save, animated: true)
            
            vehicleType.selectedSegmentIndex = 0
            vehicleTypeValueChanged(vehicleType)
            
            let currentDate = Date()
            let result = Utils.dateToString(date: currentDate)
            
//            startDate = result.strDate
//            endDate = result.strDate
//            startTime = result.strTime
//            endTime = result.strTime
            // N
            tripTab.rideData.startDate = result.strDate
            tripTab.rideData.endDate = result.strDate
            tripTab.rideData.startTime = result.strTime
            tripTab.rideData.endTime = result.strTime
            //N
            break
        case .VIEW:
            
            txtRideName.text = tripTab.rideData.rideName
            txtDesc.text = tripTab.rideData.rideDesc
            txtMaxRiders.text = tripTab.rideData.maxRider
            
            txtStartDate.text = tripTab.rideData.startDateTimeDisplay ?? ""
            txtEndDate.text = tripTab.rideData.endDateTimeDisplay ?? ""
            
            if let strURL = tripTab.rideData.rideImage?.replacingOccurrences(of: "../", with: Constant.kBASE_URL), let url = URL(string: strURL) {
                    imgRide.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "thumbnail"), options: .cacheMemoryOnly, completed: nil)
            }
            
//            if let date = tripTab.rideData.startDate, let time = tripTab.rideData.startTime {
//
//                let start_date = Utils.stringToDate(strDate: date + " " + time)
//                if let value = start_date {
//                    let result =  Utils.dateToString(date: value)
//                    startDate = result.strDate
//                    startTime = result.strTime
//                }
//            }
//
//            if let date = tripTab.rideData.endDate, let time = tripTab.rideData.endTime {
//
//                let end_date = Utils.stringToDate(strDate: date + " " + time)
//
//                if let value = end_date {
//                    let result = Utils.dateToString(date: value)
//                    endDate = result.strDate
//                    endTime = result.strTime
//                }
//            }
            
            if let type = tripTab.rideData.rideType {
                
                switch type {
                case .Car:
                    vehicleType.selectedSegmentIndex = 0
                case .Bike:
                    vehicleType.selectedSegmentIndex = 1
                case .Other:
                    vehicleType.selectedSegmentIndex = 2
                }
            }
        case .DEFAULT:
            break
        }
        
        guard let type = tripTab.participantType else {
            return
        }
        
        switch type  {
        case .OWNER:
            let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(btnSaveTapped))
            self.tabBarController?.navigationItem.setRightBarButton(save, animated: true)
            
            txtRideName.isEnabled = true
            txtDesc.isEditable = true
            txtStartDate.isEnabled = true
            txtEndDate.isEnabled = true
            txtMaxRiders.isEnabled = true
            vehicleType.isUserInteractionEnabled = true
            btnStartDate.isUserInteractionEnabled = true
            btnEndDate.isUserInteractionEnabled = true
        case .CO_RIDER:
            
            txtRideName.isEnabled = false
            txtDesc.isEditable = false
            txtStartDate.isEnabled = false
            txtEndDate.isEnabled = false
            txtMaxRiders.isEnabled = false
            vehicleType.isUserInteractionEnabled = false
            btnStartDate.isUserInteractionEnabled = false
            btnEndDate.isUserInteractionEnabled = false
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Event
    @objc func textChanged(sender: UITextField) {
        let tripTab = self.tabBarController as! TripTabVC
        switch sender.tag {
        case 0:
            tripTab.rideData.rideName = sender.text
        case 1:
            tripTab.rideData.rideDesc = sender.text
        case 2:
           tripTab.rideData.maxRider = sender.text
        default:
            break
        }
    }
    
    @IBAction func vehicleTypeValueChanged(_ sender: UISegmentedControl) {
        let tripTab = self.tabBarController as! TripTabVC
        switch sender.selectedSegmentIndex {
        case 0:
            rideMode = VehicleType.Car
            tripTab.rideData.rideType = VehicleType.Car
        case 1:
            rideMode = VehicleType.Bike
             tripTab.rideData.rideType = VehicleType.Bike
        case 2:
            rideMode = VehicleType.Other
             tripTab.rideData.rideType = VehicleType.Other
        default:
            break
        }
    }
    
    @IBAction func btnChangeRideImage(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .currentContext
        if #available(iOS 11.0, *) {
            imagePicker.navigationBar.barTintColor = UIColor(named: "BaseColor")
        } else {
            // Fallback on earlier versions
        }
        imagePicker.delegate = self
        self.tabBarController?.navigationController?.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnStartDateTapped(_ sender: UIButton) {
        
        let datePicker = Utils.tripStoryboardController(identifier: Constant.kDatePickerVC) as! DatePickerVC
        datePicker.delegate = self
        datePicker.view.tag = sender.tag
        datePicker.modalPresentationStyle = .overCurrentContext
        self.present(datePicker, animated: true, completion: nil)
    }
    
    @objc func btnSaveTapped() {
        
        //IQKeyboardManager.sharedManager().resignFirstResponder()
        IQKeyboardManager.shared.resignFirstResponder()
        let imgData: Data?
        if let image = selectedImage {
            imgData = UIImageJPEGRepresentation(image, 0.0)
        }
        else {
            imgData = nil
        }
        
        let tripTab = self.tabBarController as! TripTabVC
        
        switch tripTab.screenFor {
        case .ADD:
             presenter.postRequest(methodName: Constant.kNewRide, imgData: imgData)
        case .VIEW:
             presenter.postRequest(methodName: Constant.kUpdateRide, imgData: imgData)
        default:
            break
        }
        
        if tripTab.responseData == nil {
            //createNewRide(imgData: imgData)
            //presenter.createNewRide(imgData: imgData)
           // presenter.postRequest(methodName: Constant.kNewRide, imgData: imgData)
            
        }
        else {
            
//            if let name = txtRideName.text {
//                tripTab.rideData.rideName = name
//            }
//            if let desc = txtDesc.text {
//                tripTab.rideData.rideDesc = desc
//            }
//            tripTab.rideData.startDate = startDate
//            tripTab.rideData.startTime = startTime
//            tripTab.rideData.endDate = endDate
//            tripTab.rideData.endTime = endTime
//            tripTab.rideData.rideType = rideMode
//            tripTab.rideData.maxRider = txtMaxRiders.text ?? "0"
//
//            let param: [String:Any] = ["method":Constant.kUpdateRide,
//                                       "ride_id" : tripTab.rideData.rideID! ,
//                                       "ride_name" :  txtRideName.text ?? "New Ride",
//                                       "ride_desc" : txtDesc.text ?? "No Desc",
//                                       "ride_date_from" : startDate,
//                                       "ride_time_from" : startTime,
//                                       "ride_date_to" : endDate,
//                                       "ride_time_to" : endTime,
//                                       "ride_participant_limit" : txtMaxRiders.text ?? "0",
//                                       "ride_type": rideMode?.rawValue
//            ]
            //updateData(param: param, _imgData: imgData)
           // presenter.postRequest(methodName: Constant.kUpdateRide, imgData: imgData)
            
        }
    }
    
    //MARK:- Member Functions
//    func createNewRide(imgData: Data?) {
//
//        startLoading()
//
//        let param: [String:Any] = ["method":Constant.kNewRide,
//                                   "user_id" : UserDefaults.standard.getUserID(),
//                                   "ride_name" : txtRideName.text ?? "New Ride",
//                                   "ride_desc" : txtDesc.text ?? "No Desc",
//                                   "ride_date_from" : startDate,
//                                   "ride_time_from" : startTime,
//                                   "ride_date_to" : endDate,
//                                   "ride_time_to" : endTime,
//                                   "ride_participant_limit" : txtMaxRiders.text ?? "0",
//                                   "ride_type": rideMode.rawValue
//                                ]
//
//        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
//
//            dataManager.getDataWithImage(requestType: "POST", url: url, _params: param, imgData: imgData) { (data, error) in
//
//                if error == nil {
//
//                    let jsonDecoder = JSONDecoder()
//
//                    do {
//                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
//                        self.parseNewRideResponse(data: responseModel)
//                    }
//                    catch {
//                    }
//                }
//                else {
//
//                    self.alertError(parent: self, error: CustomError.BadRequest, title: "Error", handler: {
//                    })
//                }
//                DispatchQueue.main.async {
//                    self.stopLoading()
//                }
//            }
//        }
//    }
//
//    func parseNewRideResponse(data: BaseModel) {
//
//        self.stopLoading()
//
//        if data.content?.result_set?.count == 1 {
//            DispatchQueue.main.async {
//                self.alertError(parent: self, error: CustomError.Success, title: "Success", handler: {
//
//                    if let list = data.content?.result_set {
//                        let rideData: Result_set = list[0]
//
//                        let tripTab = self.tabBarController as! TripTabVC
//                        // tripTab.rideData.userID = rideData.user_id
//                        tripTab.rideData.rideID = rideData.ride_id
//                        tripTab.rideData.rideName = rideData.ride_name
//                        tripTab.rideData.rideDesc = rideData.ride_desc
//                        tripTab.rideData.startDate = rideData.ride_date_from
//                        tripTab.rideData.endDate = rideData.ride_date_to
//                        tripTab.rideData.startTime = rideData.ride_time_from
//                        tripTab.rideData.endTime = rideData.ride_time_to
//                        tripTab.rideData.maxRider = rideData.ride_participant_limit
//                        tripTab.rideData.rideImage = rideData.ride_image
//
//                        if rideData.ride_type == "Car" {
//                            tripTab.rideData.rideType = VehicleType.Car
//                        }
//                        else if rideData.ride_type == "Bike" {
//                            tripTab.rideData.rideType = VehicleType.Bike
//                        }
//                        else {
//                            tripTab.rideData.rideType = VehicleType.Other
//                        }
//                    }
//                })
//            }
//        }
//    }
//
//    func updateData(param:[String : Any], _imgData: Data?) {
//
//        startLoading()
//
//        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
//
//            dataManager.getDataWithImage(requestType: "POST", url: url, _params: param, imgData: _imgData) { (data, error) in
//
//                if error == nil {
//
//                    let jsonDecoder = JSONDecoder()
//                    do {
//                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
//                        self.parseResponse(data: responseModel)
//                    }
//                    catch {
//                    }
//                }
//                else {
//                    self.alertError(parent: self, error: CustomError.BadRequest, title: "Error", handler: {
//                    })
//                }
//                DispatchQueue.main.async {
//                    self.stopLoading()
//                }
//            }
//        }
//    }
//
//    func parseResponse(data: BaseModel) {
//
//        self.stopLoading()
//
//        DispatchQueue.main.async {
//
//            if data.status == Constant.kSuccess {
//
//                self.alertError(parent: self, error: CustomError.Success, title: "Success", handler: {
//                    if let list = data.content?.result_set {
//                        let rideData: Result_set = list[0]
//                        print(rideData)
//                    }
//                })
//            }
//        }
//    }
}

//MARK:- DatePickerVCDelegate
extension RideDetailsVC : DatePickerVCDelegate {
    func updateDateTime(date: String, time: String, dateTime: String, tag: Int) {
        
        let tripTab = self.tabBarController as! TripTabVC
        if tag == 0 {
//            startDate = date
//            startTime = time
            txtStartDate.text = dateTime
            tripTab.rideData.startDate = date
            tripTab.rideData.startTime = time
        }
        else {
//            endDate = date
//            endTime = time
            txtEndDate.text = dateTime
            tripTab.rideData.endDate = date
            tripTab.rideData.endTime = time
        }
    }
}

//MARK:- UIImagePickerControllerDelegate
extension RideDetailsVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true) {
            let data = info["UIImagePickerControllerOriginalImage"]
            if let img = data as? UIImage{
                self.selectedImage = img
                self.imgRide.image = self.selectedImage
            }
        }
    }
}

//MARK:- GeneralView
extension RideDetailsVC : RideDetailView {
    func updateRideID(rideID: String) {
        let tripTab = self.tabBarController as! TripTabVC
            tripTab.rideData.rideID = rideID
            tripTab.participantType = ParticipantType.OWNER
    }
    
    func updateList() { }
    func setList(list: [Result_set]) { }
    
    func showMessage(message: CustomError, title: String, reCall: Bool) {
        DispatchQueue.main.async {
            self.alertError(parent: self, error: message, title: title) {
            }
        }
    }
    
    func getRideData() -> RideData{
         let tripTab = self.tabBarController as! TripTabVC
        return tripTab.rideData
    }
}

extension RideDetailsVC : UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let tripTab = self.tabBarController as! TripTabVC
        tripTab.rideData.rideDesc = textView.text
    }
}
