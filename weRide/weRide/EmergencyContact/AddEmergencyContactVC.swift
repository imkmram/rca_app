//
//  AddEmergencyContactVC.swift
//  weRide
//
//  Created by Ashok Gupta on 04/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

protocol AddEmergencyContactVCDelegate: class {
    func updateList()
}

class AddEmergencyContactVC: BaseVC {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblTitle: UILabel!

    var presenter:EmergencyContactPresenter = EmergencyContactPresenter()
    weak var delegate: AddEmergencyContactVCDelegate?
    var action: ActionType!
    var contactData: Result_set?
    var contactID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
     
        switch action! {
        case .New:
            lblTitle.text = "Add Emergency Contact"
        case .Edit:
            lblTitle.text = "Edit Emergency Contact"
            
            if let data = contactData {
                contactID = data.contact_id
                txtName.text = data.contact_name
                txtContact.text = data.contact_no
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSaveTapped(_ sender: UIBarButtonItem) {
        saveContactData()
    }
    
    @IBAction func btnCloseTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveContactData() {
        
        startLoading()
        
        let dataManager = DataManager()
        
        var methodName: String = ""
        switch action! {
        case .New:
            methodName = Constant.kAddEmergencyContact
        case .Edit:
            methodName = Constant.kUpdateEmergencyContact
        }
        
        let param: [String:Any] = ["method" : methodName,
                                   "user_id" : UserDefaults.standard.getUserID(),
                                   "ec_id" : contactID ?? "",
                                   "ec_contact_name" : txtName.text ?? "",
                                   "ec_contact_no" : txtContact.text ?? ""
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
    
    func parseResponse(data: BaseModel) {
        
        self.stopLoading()
        
        if data.status == Constant.kSuccess {
            
            self.alertError(parent: self, error: CustomError.Success, title: "Success", handler: {
                
                self.dismiss(animated: true, completion: {
                    self.delegate?.updateList()
                })
            })
        }
        else {
            
        }
    }
}
