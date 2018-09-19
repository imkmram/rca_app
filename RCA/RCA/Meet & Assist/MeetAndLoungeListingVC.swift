//
//  MeetAndLoungeListingVC.swift
//  RCA
//
//  Created by Ashok Gupta on 19/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class MeetAndLoungeListingVC: BaseVC {
    
    @IBOutlet weak var tblProduct: UITableView!
    var service: Service_list?
    var formData: FormData?
    
    var productList: [MnA_ProductData] = []
    let presenter = MeetAndLoungeListingPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblProduct.registerCellNib(MeetAndLoungeListingCell.self)
        tblProduct.rowHeight = UITableViewAutomaticDimension
        tblProduct.estimatedRowHeight = 160
        
        guard let form = formData, let serviceData = service else {
            return
        }
        
        var methodName: String = ""
        if service?.product_id == "2" {
            methodName = Constant.MEET_ASSIST_METHOD_NAME
        }
        else {
            methodName = Constant.LOUNGE_METHOD_NAME
        }
        
        let param: [String:Any] = ["method":methodName,
                                   "product_type" : form.travelType?.rawValue ?? "",
                                   "country_code" : serviceData.country_code! ,
                                   "city" : serviceData.city!,
                                   "airport" : serviceData.airport!,
                                   "mna_adult_passengers" : form.adultCount,
                                   "mna_child_passengers" : form.childCount,
                                   "children_age" : form.childAge
                                ]
        
        presenter.attachView(view: self)
        presenter.getData(strURL: Constant.HOME_REQUEST_URL, param: param)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableView Datasource, Delegate

extension MeetAndLoungeListingVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MeetAndLoungeListingCell.identifier) as! MeetAndLoungeListingCell
        //cell.travelType = formData?.productType
        cell.formData = formData
        cell.setData(productList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: - MeetAndLounge View Protocol
extension MeetAndLoungeListingVC : MeetAndLoungeView {
    
    func setList(list: [MnA_ProductData]) {
        
        productList = list
         DispatchQueue.main.async {
            self.tblProduct.reloadData()
        }
    }
    
    func emptyList(error: CustomError, success: Bool) {
        
    }
}
