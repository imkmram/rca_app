//
//  CoRidersVC.swift
//  weRide
//
//  Created by Ashok Gupta on 25/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit
import Contacts


class CoRidersVC: BaseVC {

    @IBOutlet weak var tblCoRiders: UITableView!
    var riderList:[Participants] = []
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblCoRiders.registerCellNib(CoRiderCell.self)
        tblCoRiders.rowHeight = UITableViewAutomaticDimension
        tblCoRiders.estimatedRowHeight = 160
        
//        var contacts = [CNContact]()
//        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
//        let request = CNContactFetchRequest(keysToFetch: keys)
//
//        do {
//
//            let contactStore = CNContactStore()
//
//            try contactStore.enumerateContacts(with: request) {
//                (contact, stop) in
//                // Array containing all unified contacts from everywhere
//                contacts.append(contact)
//            }
//        }
//        catch {
//            print("unable to fetch contacts")
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        let tripTab = self.tabBarController as! TripTabVC
    
        self.tabBarController?.navigationItem.title = "Co Rider"
        self.tabBarController?.navigationItem.rightBarButtonItems = nil
    
        riderList = tripTab.participants

        if tripTab.screenFor == .ADD || tripTab.participantType == .OWNER {

            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddTapped))
            self.tabBarController?.navigationItem.setRightBarButtonItems([add], animated: true)
        }
    }

    @objc func btnAddTapped() {
        
//        let contactVC = Utils.tripStoryboardController(identifier: Constant.kContactListingVC) as! ContactListingVC
//
//        //self.tabBarController?.navigationController?.pushViewController(contactVC, animated: true)
//
//        self.tabBarController?.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.pushViewController(contactVC, animated: true)
        
        let addCoRider = Utils.tripStoryboardController(identifier: Constant.kAddCoRider_VC) as! AddCoRiderVC
        addCoRider.delegate = self
        addCoRider.action = ActionType.New
        addCoRider.modalPresentationStyle = .overCurrentContext
        self.present(addCoRider, animated: true, completion: nil)
    }
    
    func presentActionSheet() {
        
        let actionSheetVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete Rider", style: .destructive){ (action) in
            
            self.deleteRider()
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .default){ (action) in
            
            let data = self.riderList[self.selectedIndex]
            
            let addCoRider = Utils.tripStoryboardController(identifier: Constant.kAddCoRider_VC) as! AddCoRiderVC
            addCoRider.delegate = self
            addCoRider.action = ActionType.Edit
            addCoRider.riderData = data
            addCoRider.modalPresentationStyle = .overCurrentContext
            self.present(addCoRider, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetVC.addAction(deleteAction)
        actionSheetVC.addAction(editAction)
        actionSheetVC.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(actionSheetVC, animated: true, completion: nil)
        }
    }
    
    func deleteRider() {
        startLoading()
        
        let dataManager = DataManager()
        let data = self.riderList[self.selectedIndex]
        
        let param: [String:Any] = ["method" : Constant.kDeleteParticipant,
                                   "participant_id" : data.participant_id!
        ]
        
        if let url = URL(string: Constant.kBASE_URL.appending(Constant.kAPI_URL)) {
            
            dataManager.getData(requestType: "POST", url: url , parameter: param) { (data, error) in
                
                if error == nil {
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let responseModel = try jsonDecoder.decode(BaseModel.self, from: data!)
                        if responseModel.status == Constant.kSuccess {
                            self.alertError(parent: self, error: CustomError.Delete, title: "Success", handler: {
                                self.riderList.remove(at: self.selectedIndex)
                                self.tblCoRiders.reloadData()
                               // self.updateList()
                            })
                        }
                    }
                    catch {
                        print("TRY BEEN CAUGHT")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CoRidersVC : AddCoriderVCDelegate {
    func updateList(data: Participants) {
        riderList.append(data)
        tblCoRiders.reloadData()
    }
}

extension CoRidersVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CoRiderCell.identifier) as! CoRiderCell
        
        cell.setData(riderList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
         let tripTab = self.tabBarController as! TripTabVC
        if tripTab.participantType == ParticipantType.OWNER {
            presentActionSheet()
        }
    }
}
