//
//  MoreListingVC.swift
//  RCA
//
//  Created by Ashok Gupta on 06/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class MoreListingVC: BaseVC {
    
    @IBOutlet weak var collectionViewMore: UICollectionView!
    var moreList: [Service_list] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewMore.registerCellNib(ServiceCell.self)
        collectionViewMore.delegate = self
        collectionViewMore.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UICollectionView Datasource, Delegate
extension MoreListingVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moreList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCell.identifier, for: indexPath) as! ServiceCell
        cell.setData(data: moreList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWith: CGFloat = self.view.bounds.width
        let cellWidth: CGFloat = (screenWith - 30) / 2
        
        return CGSize(width: cellWidth, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let service = moreList[indexPath.row] 
        
        if service.product_id == "1" {
            let detailVC = Utils.getE_visaStoryboardController(identifier: Constant.VIEWCONTROLLER_E_VisaDetail) as! E_VisaDetailVC
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        else {
            let meetAssistVC = Utils.getMeet_AssistStoryboardController(identifier: Constant.MEETASSISTFORM_VC) as! MeetAndLoungeFormVC
            meetAssistVC.service = service
            
            self.navigationController?.pushViewController(meetAssistVC, animated: true)
        }
    }
}

extension MoreListingVC : NewHomeCellDelegate {
    func serviceTapped(service: Service_list, collectionViewTag: Int?) {
        
    }
}
