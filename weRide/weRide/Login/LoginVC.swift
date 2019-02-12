//
//  LoginVC.swift
//  weRide
//
//  Created by Ashok Gupta on 25/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    @IBAction func btnSignupTapped(_ sender: UIButton) {
        
        let window = UIApplication.shared.keyWindow
        let signupVC  = Utils.loginStoryboardController(identifier:Constant.kSignUp_VC) as! SignupVC
        
        let rootNav = window?.rootViewController as! UINavigationController
        rootNav.setViewControllers([signupVC], animated: true)
    }
    
    @IBAction func btnLoginTapped(_ sender: RoundButton) {
        
        lblError.text = ""

        if txtEmail.text != "" && txtPassword.text != "" {
            
            validateUser()
        }
        else {
            
            if txtEmail.text == "" {
                lblError.text = "Enter your email id"
            }
            else if txtPassword.text == "" {
                lblError.text = "Enter your password"
            }
        }
    }
    
    func validateUser() {
        
        startLoading()
        
        let dataManager = DataManager()
        
        let param: [String:Any] = ["method":Constant.kLogin,
                                   "user_email_id" : txtEmail.text ?? "",
                                   "user_password" : txtPassword.text ?? ""
        ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : AnyObject]
                        
                        print(json)
                    }
                    catch {
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    do {
                        
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        self.parseResponse(data: responseModel)
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
    
    func parseResponse(data: BaseModel) {
        
        DispatchQueue.main.async {
            
            if data.content?.flag == 0 {
                
                if let list = data.content?.result_set {
                    let userData: Result_set = list[0]
                    UserDefaults.standard.setUserID(value:userData.user_id!)
                    UserDefaults.standard.setLoggedIn(value: true)
                    UserDefaults.standard.setUserName(value: userData.user_name!)
                    UserDefaults.standard.setEmailID(value: userData.user_email_id!)
                    UserDefaults.standard.setMobileNo(value: userData.user_mobile_no!)
                    
                   // if let profileImg = userData.user_profile_pic {
                         UserDefaults.standard.setProfileImage(value: userData.user_profile_pic ?? "")
                    //}
                    self.pushToDashboard()
                }
            }
            else if data.content?.flag == 2 {
                self.alertError(parent: self, error: CustomError.NonVerifiedUser, title: "OK") {
                    
                    let otpVC = Utils.loginStoryboardController(identifier: Constant.kOTP_VC) as! OTPVC
                    otpVC.emailID = self.txtEmail.text ?? ""
                    self.navigationController?.pushViewController(otpVC, animated: true)
                }
            }
            else if data.content?.flag == 5{
                self.alertError(parent: self, error: CustomError.InvalidPassword, title: "OK") {
                }
            }
            else if data.content?.flag == 6 {
                self.alertError(parent: self, error: CustomError.InvalidUserName, title: "OK") {
                }
            }
            else {
                self.alertError(parent: self, error: CustomError.DatabaseError, title: "OK") {
                }
            }
        }
    }
}
