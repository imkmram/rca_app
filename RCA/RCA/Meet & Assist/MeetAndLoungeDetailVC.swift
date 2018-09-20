//
//  MeetAndLoungeDetailVC.swift
//  RCA
//
//  Created by Ashok Gupta on 20/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class MeetAndLoungeDetailVC: UIViewController {

    var productData: MnA_ProductData?
    var serviceData: ServiceData?
    var formData: FormData?
    
    @IBOutlet weak var tblDetail: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tblDetail.registerCellNib(DetailHeaderCell.self)
        tblDetail.registerCellNib(DetailDescCell.self)
        tblDetail.rowHeight = UITableViewAutomaticDimension
        tblDetail.estimatedRowHeight = 160
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MeetAndLoungeDetailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderCell.identifier) as! DetailHeaderCell
            
            if let product = productData, let service = serviceData, let form = formData {
                 cell.setData(productData: product, serviceData: service, formData: form)
            }
            return cell
        }
        else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescCell.identifier) as! DetailDescCell
            
            cell.setData(productData)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }    
}
