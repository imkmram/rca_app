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
        tblDetail.registerCellNib(DetailImageCell.self)
        tblDetail.rowHeight = UITableViewAutomaticDimension
        tblDetail.estimatedRowHeight = 160
        
        let titleView = ConcealingTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        titleView.text = (productData?.product_name!)! + " by " + (productData?.supplier!)!
        navigationItem.titleView = titleView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let titleView = navigationItem.titleView as? ConcealingTitleView else { return }
        titleView.scrollViewDidScroll(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MeetAndLoungeDetailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageCell.identifier) as! DetailImageCell
            
            cell.setData(nil)
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescCell.identifier) as! DetailDescCell
            
            cell.setData(productData)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            return 200
        }
        else {
            return UITableViewAutomaticDimension
        }
    }    
}
