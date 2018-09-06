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
    var serviceList: [[String : Any]] = []
    let presenter = HomePresenter()
    var isSuccess:Bool = false
    var message:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblHome.registerCellNib(NewHomeCell.self)
        tblHome.registerCellNib(HomeCell.self)
        tblHome.rowHeight = UITableViewAutomaticDimension
        tblHome.estimatedRowHeight = 160
        tblHome.isHidden = true
        super.delagate = self
        
        presenter.attachView(view: self)
        presenter.getData(strURL: Constant.HOME_REQUEST_URL)
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

// MARK: - UITableView Datasource, Delegate
extension HomeVC : UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSuccess {
            return serviceList.count
        }
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSuccess {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: NewHomeCell.identifier) as! NewHomeCell
            
            cell.delegate = self
            cell.tag = indexPath.row
            cell.setList(dict: serviceList[indexPath.row])
        
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if indexPath.row == 0 {
//            let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
//            let eVisaVC = storyboard.instantiateViewController(withIdentifier: Constant.VIEWCONTROLLER_E_VISA) as! E_VisaVC
//            let backItem = UIBarButtonItem()
//            backItem.title = "Back"
//            navigationItem.backBarButtonItem = backItem
//            self.navigationController?.pushViewController(eVisaVC, animated: true)
//        }
    }
}

// MARK: - HomeView
extension HomeVC : HomeView {
    func setList(data: [[String : Any]]?, success: Bool) {
        isSuccess = success
        
         if let list = data {
            serviceList = list
            
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

// MARK: - BaseView Delegate
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

// MARK: - NewHomeCell Delegate
extension HomeVC : NewHomeCellDelegate {
    
    func serviceTapped(service: ServiceModel, collectionViewTag: Int?) {
        
        if service.product_id == "0" {
           
          let moreLsitingVC =  Utils.getMainStoryboardController(identifier: Constant.VIEWCONTROLLER_MORELISTING) as! MoreListingVC
            
            if let list: [ServiceModel] = serviceList[collectionViewTag!]["list"] as? [ServiceModel] {
                moreLsitingVC.moreList = list
            }
            self.navigationController?.pushViewController(moreLsitingVC, animated: true)
        }
        else {
            
           let detailVC = Utils.getE_visaStoryboardController(identifier: Constant.VIEWCONTROLLER_E_VisaDetail) as! E_VisaDetailVC
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

