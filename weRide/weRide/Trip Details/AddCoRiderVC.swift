//
//  AddCoRiderVC.swift
//  weRide
//
//  Created by Ashok Gupta on 01/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

protocol AddCoriderVCDelegate: class {
    func updateList(data: Participants)
}

class AddCoRiderVC: BaseVC {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    weak var delegate: AddCoriderVCDelegate?
    
    var action: ActionType!
    var riderData: Participants?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.layer.cornerRadius = 10.0
        
        switch action! {
        case .New:
            lblTitle.text = "Add Co-Rider"
        case .Edit:
            lblTitle.text = "Edit Co-Rider"
            
            if let data = riderData {
                txtName.text = data.name
                txtEmail.text = data.email_id
                txtMobile.text = data.mobileno
            }
        }
    }

    func createCoRider() {
        
        startLoading()
        
        let dataManager = DataManager()
        let tripTab = self.presentingViewController as! TripTabVC
        var methodName: String = ""
        
        let param: [String:Any] = ["method" : Constant.kAddCoRider,
                                   "user_id" : UserDefaults.standard.getUserID(),
                                   "ride_id" : tripTab.rideData.rideID!,
                                   "participant_name" : txtName.text ?? "",
                                   "participant_email_id" : txtEmail.text ?? "",
                                   "participant_mobile_no" : txtMobile.text ?? ""
                                ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                    }
                    catch {
                        print("Caught")
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        self.parseNewRideResponse(data: responseModel)
                    }
                    catch {
                        
                        print("TRY BEEN CAUGHET")
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
    
    func parseNewRideResponse(data: BaseModel) {
        
            self.stopLoading()
            
            if data.status == Constant.kSuccess {
                
              //  DispatchQueue.main.async {
                
                if let list = data.content?.result_set {
                    
                    if list.count > 0 {
                        
                        if let participant = list[0].participants {
                            
                            self.dismiss(animated: true, completion: {
                                self.delegate?.updateList(data: participant[0])
                            })
                        }
                    }
                    
 //                   if let participant: Participants = list[0].participants?[0] {
//                        var addedRider: Participants = Participants()
//                        addedRider.username = participant.username
//                        addedRider.email_id = participant.email_id
//                        addedRider.mobileno = pa
//                        addedRider.participant_id = data.content.
 //                   }
                }
                
                
                
                
              //  }
            }
            else {
                
            }
    }
 
    @IBAction func btnSaveTapped(_ sender: UIBarButtonItem) {
    
        createCoRider()
    }

    @IBAction func btnCancelTapped(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
