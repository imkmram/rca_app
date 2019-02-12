//
//  MyProfileVC.swift
//  weRide
//
//  Created by Ashok Gupta on 08/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class MyProfileVC: BaseVC {
    
    //MAEK:- Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgHeightConstant: NSLayoutConstraint!
    
    //MARK:- Member Variable
    private var presenter:MyProfilePresenter = MyProfilePresenter()
    var selectedImgData: Data?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
         imgProfile.layer.cornerRadius = imgHeightConstant.constant / 2
        imgProfile.layer.masksToBounds = true
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "My Profile"
        
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(btnSaveTapped))
        self.navigationItem.setRightBarButtonItems([save], animated: true)
        
        txtName.text = UserDefaults.standard.getUserName()
        txtEmail.text = UserDefaults.standard.getEmail()
        txtMobile.text = UserDefaults.standard.getMobileNo()
        
        let strURL = UserDefaults.standard.getProfileImage()
        
        if let url = URL(string: "http://".appending(strURL)) {
             imgProfile.sd_setImage(with: url, placeholderImage: nil, options: .continueInBackground, completed: nil)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        presenter.detachView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Event
    @IBAction func btnSelectImageTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .currentContext
        if #available(iOS 11.0, *) {
            imagePicker.navigationBar.barTintColor = UIColor(named: "BaseColor")
        } else {
            // Fallback on earlier versions
        }
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func btnSaveTapped() {
        presenter.updateProfile(userName: txtName.text ?? "", userMobileNo: txtMobile.text ?? "", imgData: selectedImgData)
    }
}

//MARK:- UIImagePickerControllerDelegate
extension MyProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true) {
            
            let data = info["UIImagePickerControllerOriginalImage"]
            if let img = data as? UIImage{
                self.imgProfile.image = img
                self.selectedImgData = UIImageJPEGRepresentation(img, 0.0)
            }
        }
    }
}
//MARK:- GeneralView
extension MyProfileVC : GeneralView {
    func updateList() {
    }
    
    func setList(list: [Result_set]) {
        
        let data = list[0]
        if let mobileNo = data.user_mobile_no {
            UserDefaults.standard.setMobileNo(value: mobileNo)
        }
        if let img = data.user_profile_pic {
            UserDefaults.standard.setProfileImage(value: img)
        }
    }
    
    func showMessage(message: CustomError, title: String, reCall: Bool) {
        
        alertError(parent: self, error: message, title: title) {
        }
    }
}
