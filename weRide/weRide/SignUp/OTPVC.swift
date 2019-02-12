//
//  OTPVC.swift
//  weRide
//
//  Created by Ashok Gupta on 25/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class OTPVC: BaseVC {
    
    var emailID: String?
    var error: CustomError?
    
    @IBOutlet weak var txtDigitFour: UITextField!
    @IBOutlet weak var txtDigitThree: UITextField!
    @IBOutlet weak var txtDigitTwo: UITextField!
    @IBOutlet weak var txtDigitOne: UITextField!
    
    var strOTP: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtDigitOne.resignFirstResponder()
        
        txtDigitOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtDigitTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtDigitThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtDigitFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case txtDigitOne:
                txtDigitTwo.becomeFirstResponder()
            case txtDigitTwo:
                txtDigitThree.becomeFirstResponder()
            case txtDigitThree:
                txtDigitFour.becomeFirstResponder()
            case txtDigitFour:
                txtDigitFour.resignFirstResponder()
                strOTP = txtDigitOne.text! + txtDigitTwo.text! + txtDigitThree.text! + txtDigitFour.text!
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case txtDigitOne:
                txtDigitOne.becomeFirstResponder()
            case txtDigitTwo:
                txtDigitOne.becomeFirstResponder()
            case txtDigitThree:
                txtDigitTwo.becomeFirstResponder()
            case txtDigitFour:
                txtDigitThree.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
    
    @IBAction func btnResendTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnVerifyTapped(_ sender: UIButton) {
        validateOTP()
    }
    
    func validateOTP() {
        
        startLoading()
        
        let dataManager = DataManager()
        
        let param: [String:Any] = ["method":Constant.kOTPVerification,
                                   "user_email_id" : emailID ?? "",
                                   "user_otp" : strOTP
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
                    UserDefaults.standard.setProfileImage(value: userData.user_profile_pic!)
                    
                    self.pushToDashboard()
                }
            }
            else if data.content?.flag == 2 {
                self.alertError(parent: self, error: CustomError.NonVerifiedUser, title: "OK") {
                    
                    let otpVC = Utils.loginStoryboardController(identifier: Constant.kOTP_VC) as! OTPVC
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
