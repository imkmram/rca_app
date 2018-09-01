//
//  HomeVC.swift
//  RCA
//
//  Created by TWC on 02/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: BaseVC {

    @IBOutlet weak var tblHome: UITableView!
    var serviceList:[Service] = []
    let presenter = HomePresenter()
    var isSuccess:Bool = false
    var message:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblHome.registerCellNib(HomeCell.self)
        tblHome.rowHeight = UITableViewAutomaticDimension
        tblHome.estimatedRowHeight = 160
        tblHome.isHidden = true
        super.delagate = self
        
        presenter.attachView(view: self)
        presenter.getData(strURL: "https://www.google.com")
        
//        let imgURL = URL(string: "https://yt3.ggpht.com/a-/ACSszfFVNourOmj3-ytJECQCieFxpQ9ztjHTChKmCg=s900-mo-c-c0xffffffff-rj-k-no")
//        DataManager.downloadFile(fileName: "test", url: imgURL!)
        
        let passportType = PassportType()
        var list = passportType.selectAllFrom(entityName: "PassportType") as [PassportType]
        
        print(list)
        
        for data in list {
           // print("===========\(data.type_name!)========")
        }
       let result = passportType.deleteAllFrom(entityName: "PassportType")
          list = passportType.selectAllFrom(entityName: "PassportType") as [PassportType]
        
        print(list)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func viewDidDisappear(_ animated: Bool) {
       // presenter.detachView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeVC : UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSuccess {
             return serviceList.count
        }
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSuccess {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier) as! HomeCell
            let data : Service = serviceList[indexPath.row]
            cell.setData(data)
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
            let eVisaVC = storyboard.instantiateViewController(withIdentifier: Constant.VIEWCONTROLLER_E_VISA) as! E_VisaVC
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(eVisaVC, animated: true)
        }
    }
}

extension HomeVC : HomeView {
    
    func setList(data: [Service]?, success: Bool) {
        
        isSuccess = success
        if let services = data {
            serviceList = services
            DispatchQueue.main.async {
                self.removeErrorPage(parent: self)
                self.tblHome.isHidden = false
                self.tblHome.reloadData()
            }
        }
    }
    
    func emptyList(error: CustomError, success: Bool) {
        
        isSuccess = success
        self.tblHome.isHidden = true
        loadErrorPage(parent: self, error: error)
    }
    
//    func setList<T>(data: [T]) {
//
//        serviceList = data as! [Service]
//        DispatchQueue.main.async {
//            self.tblHome.reloadData()
//        }
//    }
}

extension HomeVC : BaseViewDelegate {

    func networkStausChanged(isReachable: Bool) {

        if isReachable {

            if serviceList.count == 0 {
                presenter.reloadDataCall()
            }
        }
        else {
           // presenter.pauseDataCall()
        }
    }
}

