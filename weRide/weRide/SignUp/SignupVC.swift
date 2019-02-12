//
//  SignupVC.swift
//  weRide
//
//  Created by Ashok Gupta on 25/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit
//import SVProgressHUD

class SignupVC: BaseVC {
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var txtRePassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    var email: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func validate() -> Bool {
        
        if txtName.text?.length == 0 {
            lblMessage.text = "Name cannot be empty"
         return false
        }
        else if txtEmail.text?.length == 0 {
            lblMessage.text = "Email cannot be empty"
            return false
        }
        else if txtMobile.text?.length == 0 {
            lblMessage.text = "Mobile number cannot be empty"
            return false
        }
        else if txtPassword.text?.length == 0 || txtRePassword.text?.length == 0 {
            lblMessage.text = "Password cannot be empty"
            return false
        }
        else if txtPassword.text != txtRePassword.text {
            lblMessage.text = "Retype password does not match, re-enter."
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func btnSignupTapped(_ sender: RoundButton) {
        
        lblMessage.text = ""
        
        if validate() {
            if let value = txtEmail.text {
                
                email = value
                
                startLoading()
                
                let dataManager = DataManager()
                
                let param: [String:Any] = ["method":Constant.kSignUp,
                                           "user_name" : txtName.text ?? "",
                                           "user_email_id" : value,
                                           "user_mobile_no" : txtMobile.text ?? "",
                                           "user_password" : txtPassword.text ?? "",
                                           "user_device_type" : "ios",
                                           "user_device_id" : ""
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
                                
                            }
                        }
                        else {
                            
                        }
                        DispatchQueue.main.async {
                            self.stopLoading()
                        }
                    }
                }
            }
        }
    }
    
    func parseResponse(data: BaseModel) {
        
            self.stopLoading()
        
          DispatchQueue.main.async {
            
            if data.content?.flag == 0 {
                
                let otpVC = Utils.loginStoryboardController(identifier: Constant.kOTP_VC) as! OTPVC
                otpVC.emailID = self.email
                self.navigationController?.pushViewController(otpVC, animated: true)
            }
            else if data.content?.flag == 1 {
                
                let otpVC = Utils.loginStoryboardController(identifier: Constant.kOTP_VC) as! OTPVC
                otpVC.error = CustomError.OTPError
                self.navigationController?.pushViewController(otpVC, animated: true)
            }
            else if data.content?.flag == 2 {
                
                self.alertError(parent: self, error: CustomError.DatabaseError, title: "Server Error", handler: {
                })
            }
            else if data.content?.flag == 3 {
                
                self.alertError(parent: self, error: CustomError.UserExsits, title: "Message Error", handler: {
                    
                    let window = UIApplication.shared.keyWindow
                    let loginVC  = Utils.loginStoryboardController(identifier:Constant.kLogin_VC) as! LoginVC
                    let rootNav = window?.rootViewController as! UINavigationController
                    rootNav.setViewControllers([loginVC], animated: true)
                })
            }
            else if data.content?.flag == 4 {
                
                self.alertError(parent: self, error: CustomError.FieldValidationError, title: "Error", handler: {
                })
            }
            else {
                let otpVC = Utils.loginStoryboardController(identifier: Constant.kOTP_VC) as! OTPVC
                otpVC.emailID = self.txtEmail.text ?? ""
                self.navigationController?.pushViewController(otpVC, animated: true)
            }
        }
    }
    
    @IBAction func btnLogInTapped(_ sender: UIButton) {
        
        let window = UIApplication.shared.keyWindow

        let loginVC  = Utils.loginStoryboardController(identifier:Constant.kLogin_VC) as! LoginVC
        let rootNav = window?.rootViewController as! UINavigationController
        rootNav.setViewControllers([loginVC], animated: true)
    }
}
