//
//  EmergencyContactVC.swift
//  weRide
//
//  Created by Ashok Gupta on 04/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class EmergencyContactVC: BaseVC {

    //MARK:- Outlet
    @IBOutlet weak var tblContact: UITableView!
    
    //MARK:- Member Variables
    var presenter:EmergencyContactPresenter = EmergencyContactPresenter()
    var contactList:[Result_set] = []
    var selectedIndex: Int = 0
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tblContact.registerCellNib(EmergencyCell.self)
        tblContact.rowHeight = UITableViewAutomaticDimension
        tblContact.estimatedRowHeight = 160
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Emergency Contact"
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(btnAddTapped))
        self.navigationItem.setRightBarButtonItems([add], animated: true)
        
        presenter.getContactList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.detachView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Event
    func presentActionSheet() {
        
        let actionSheetVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete Contact", style: .destructive){ (action) in
            let data = self.contactList[self.selectedIndex]
            self.presenter.deleteContact(data: data)
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .default){ (action) in
            
            let data = self.contactList[self.selectedIndex]
            let addContactVC = Utils.profileStoryboardController(identifier: Constant.kAddEmergencyContact_VC) as! AddEmergencyContactVC
            addContactVC.delegate = self
            addContactVC.contactData = data
            addContactVC.action = ActionType.Edit
            
            addContactVC.modalPresentationStyle = .overCurrentContext
            self.present(addContactVC, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetVC.addAction(deleteAction)
        actionSheetVC.addAction(editAction)
        actionSheetVC.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(actionSheetVC, animated: true, completion: nil)
        }
    }
    
    @objc func btnAddTapped() {
        let addEmergencyVC = Utils.profileStoryboardController(identifier: Constant.kAddEmergencyContact_VC) as! AddEmergencyContactVC
        addEmergencyVC.delegate = self
        addEmergencyVC.action = ActionType.New
        addEmergencyVC.modalPresentationStyle = .overCurrentContext
        self.present(addEmergencyVC, animated: true, completion: nil)
    }
}

//MARK:- AddEmergencyContactVCDelegate
extension EmergencyContactVC : AddEmergencyContactVCDelegate {
    func updateList() {
       presenter.getContactList()
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension EmergencyContactVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EmergencyCell.identifier) as! EmergencyCell
        let data = contactList[indexPath.row]
        cell.setData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        presentActionSheet()
    }
}

//MARK:- GeneralView
extension EmergencyContactVC : GeneralView {
    func setList(list: [Result_set]) {
        contactList = list
        DispatchQueue.main.async {
         self.tblContact.reloadData()
        }
    }
    
    func showMessage(message: CustomError, title: String, reCall: Bool) {
        
        alertError(parent: self, error: message, title: title) {
            if reCall {
                self.updateList()
            }
        }
    }
}
