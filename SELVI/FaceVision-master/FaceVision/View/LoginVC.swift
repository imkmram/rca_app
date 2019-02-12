//
//  LoginVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 22/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    
    var selectedButtonTag: Int = 0
    var name: String?
    var message: String = ""
    var validationMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSignUpTapped(btnSignUp)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        
        selectedButtonTag = 0
        btnSignIn.backgroundColor = UIColor.white
        btnSignIn.setTitleColor(UIColor.black, for: .normal)
        
        btnSignUp.backgroundColor = UIColor.black
        btnSignUp.setTitleColor(UIColor.white, for: .normal)
        
        nameView.isHidden = false
        btnForgotPassword.isHidden = true
    }
    
    @IBAction func btnSignInTapped(_ sender: Any) {
        
        selectedButtonTag = 1
        btnSignUp.backgroundColor = UIColor.white
        btnSignUp.setTitleColor(UIColor.black, for: .normal)
        
        btnSignIn.backgroundColor = UIColor.black
        btnSignIn.setTitleColor(UIColor.white, for: .normal)
        
        nameView.isHidden = true
        btnForgotPassword.isHidden = false
    }
    
    @IBAction func btnForgotPasswordTapped(_ sender: Any) {
        let forgotVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    func validate(name: String?, email: String?, password: String?) -> (Bool, String) {
        
        if name?.isEmpty ?? true {
            return (false, "Name cannot be left blank.")
        }
        else if email?.isEmpty ?? true {
            return (false, "Email cannot be left blank.")
        }
        else if password?.isEmpty ?? true {
            return (false, "Password cannot be left blank.")
        }
        else if !(name?.isAlphanumeric)!  {
            return (false, "Only alpha characters accepted.")
        }
        else if (email?.isValidEmail)! {
            return (false, "Invalid email id.")
        }
        else {
            return (true, "")
        }
    }
    
    func validate(email: String?, password: String?) -> (Bool, String) {
       
         if email?.isEmpty ?? true {
            return (false, "Email cannot be left blank.")
        }
        else if password?.isEmpty ?? true {
            return (false, "Password cannot be left blank.")
        }
        else if (email?.isValidEmail)! {
            return (false, "Invalid email id.")
        }
        else {
            return (true, "")
        }
    }
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        if selectedButtonTag == 0 {
            
            let result = validate(name: txtName.text, email: txtEmail.text, password: txtPassword.text)
            if result.0 {
                signUp()
            }
            else {
                showToast(title: "ERROR......", message: result.1)
            }
        }
        else {
             let result = validate(email: txtEmail.text, password: txtPassword.text)
             if result.0 {
                signIn()
            }
            else {
                showToast(title: "ERROR......", message: result.1)
            }
        }
    }
    
    func signUp() {
        
        SVProgressHUD.show()
        
        self.name = txtName.text
        
        if let name = self.name, let email = txtEmail.text, let password = txtPassword.text {
            let user = User(user_id: nil, name: name, email: email
                , password: password, method: "signup")
            
            let encodedData = try? JSONEncoder().encode(user)
            
            if let data = encodedData {
                let str = String(data: data, encoding: .utf8)
                
                if let url = URL(string: Constant.kBaseURL) {
                    
                    fetchUsers(url: url, method: "POST", parameter: str!) { (response) in
                        
                        DispatchQueue.main.async {
                            switch response {
                            case .success(let baseModel):
                                self.message = "Registered successfully, continue to download."
                                self.parseSignUpResponse(model: baseModel)
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
    
    func parseSignUpResponse(model: BaseModel) {
        
        SVProgressHUD.dismiss()
        
        if model.result?.status == 1 {
            
            UserDefaults.standard.setLoggedIn(value: true)
            UserDefaults.standard.setUserID(value: (model.result?.user?.user_id)!)
            UserDefaults.standard.setUserName(value: self.name!)
            UserDefaults.standard.setEmailID(value: self.txtEmail.text!)
            
            let alert = UIAlertController(title: "SUCCESS", message: self.message, preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title: "Continue", style: .cancel) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(actionOK)
            
            self.present(alert, animated: true, completion: nil)
        }
        else if model.result?.status == 2 {
            showAlertWith(title: "Error", message: "Already a registered user. Please sign in.")
        }
        else {
            showAlertWith(title: "Error", message: "Server error. Please try again.")
        }
    }
    
    private func signIn() {
        
        SVProgressHUD.show()
        if let email = txtEmail.text, let password = txtPassword.text {
            let user = User(user_id: nil, name: nil, email: email
                , password: password, method: "login")
            
            let encodedData = try? JSONEncoder().encode(user)
            
            if let data = encodedData {
                let str = String(data: data, encoding: .utf8)
                
                if let url = URL(string:Constant.kBaseURL) {
                    
                    fetchUsers(url: url, method: "POST", parameter: str!) { (response) in
                        
                        DispatchQueue.main.async {
                            switch response {
                            case .success(let baseModel):
                                self.name = baseModel.result?.user?.name
                                self.message = "LoggedIn successfully, continue to download"
                                self.parseSignInResponse(model: baseModel)
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
    
    
    func parseSignInResponse(model: BaseModel) {
        
        SVProgressHUD.dismiss()
        
        if model.result?.status == 1 {
            
            UserDefaults.standard.setLoggedIn(value: true)
            UserDefaults.standard.setUserID(value: (model.result?.user?.user_id)!)
            UserDefaults.standard.setUserName(value: self.name!)
            UserDefaults.standard.setEmailID(value: self.txtEmail.text!)
            
            let alert = UIAlertController(title: "SUCCESS", message: self.message, preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title: "Continue", style: .cancel) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(actionOK)
            
            self.present(alert, animated: true, completion: nil)
        }
        else if model.result?.status == 0 {
            showAlertWith(title: "Error", message: "Invalid Email id. User does not exist.")
        }
        else if model.result?.status == 2 {
            showAlertWith(title: "Error", message: "Incorrect password. Please try again or click Forgot password")
        }
        else {
            showAlertWith(title: "Error", message: "Server error. Please try again.")

        }
    }
}
