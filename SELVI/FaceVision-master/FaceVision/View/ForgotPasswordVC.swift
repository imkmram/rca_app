//
//  ForgotPasswordVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 25/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var btnTitle: RoundButton!
    @IBOutlet weak var btnContinue: RoundButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var passwordView: UIView!

    var isEmailVerified: Bool = false
    var userID:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        
        SVProgressHUD.show()
        
        let result = validate(email: txtEmail.text, password: txtPassword.text)
        
        if result.0 {
            if isEmailVerified {
                changePassword()
            }
            else {
                if let _ = txtPassword.text{
                        verifyEmail()
                }
                else {
                    showToast(title: "ERROR.....", message: "Password cannot be blank.")
                }
            }
        }
        else {
            SVProgressHUD.dismiss()
            showToast(title: "ERROR......", message: result.1)
        }
    }
    
    private func verifyEmail() {
        
        
        if let email = txtEmail.text {
            let user = User(user_id: nil, name: nil, email: email
                , password: nil, method: "forgotpassword")
            
            let encodedData = try? JSONEncoder().encode(user)
            
            if let data = encodedData {
                let str = String(data: data, encoding: .utf8)
                
                if let url = URL(string: Constant.kBaseURL) {
                    
                    fetchUsers(url: url, method: "POST", parameter: str!) { (response) in
                        
                        DispatchQueue.main.async {
                            switch response {
                            case .success(let baseModel):
                                
                                self.parseEmailResponse(model: baseModel)
                                print("Success")
                                
                            case .failure(let error):
                                self.showAlertWith(title: "Error", message: error.localizedDescription)
                                print("Failure")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func parseEmailResponse(model: BaseModel) {
        
        SVProgressHUD.dismiss()
        if model.result?.status == 1 {
        
            passwordView.isHidden = false
            userID = model.result?.user?.user_id!
            btnTitle.setTitle("CHANGE PASSWORD", for: .normal)
            isEmailVerified = true
        }
//        else {
//            showAlertWith(title: "Error", message: (model.result?.msg!)!)
//        }
        
        else if model.result?.status == 0 {
            showAlertWith(title: "Error......", message: "Invalid Email id. User does not exist.")
        }
        else {
            showAlertWith(title: "Error......", message: "Server error, try again")
        }
    }
    
    func changePassword() {
        
        if let email = txtEmail.text, let password = txtPassword.text {
            let user = User(user_id: userID, name: nil, email: email
                , password: password, method: "changePassword")
            
            let encodedData = try? JSONEncoder().encode(user)
            
            if let data = encodedData {
                let str = String(data: data, encoding: .utf8)
                
                if let url = URL(string: Constant.kBaseURL) {
                    
                    fetchUsers(url: url, method: "POST", parameter: str!) { (response) in
                        
                        DispatchQueue.main.async {
                            switch response {
                            case .success(let baseModel):
                                
                                self.parseChangePasswordResponse(model: baseModel)
                                print("Success")
                                
                            case .failure(let error):
                                self.showAlertWith(title: "Error", message: error.localizedDescription)
                                print("Failure")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func parseChangePasswordResponse(model: BaseModel) {
        SVProgressHUD.dismiss()
        if model.result?.status == 1 {
        
                        let alert = UIAlertController(title: "SUCCESS", message: "Password changed successfully, continue to login", preferredStyle: .alert)
            
                        let actionOK = UIAlertAction(title: "Continue", style: .cancel) { (action) in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(actionOK)
            
                        self.present(alert, animated: true, completion: nil)
        }
        else {
            showAlertWith(title: "Error", message: (model.result?.msg!)!)
        }
    }
    
    func validate(email: String?, password: String?) -> (Bool, String) {
        
        if email?.isEmpty ?? true {
            return (false, "Email cannot be left blank.")
        }
        else if (email?.isValidEmail)! {
            return (false, "Invalid email id.")
        }
        else {
            return (true, "")
        }
    }
}
