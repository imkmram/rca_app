 //
//  NewHomeCell.swift
//  RCA
//
//  Created by Ashok Gupta on 05/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
 
 protocol NewHomeCellDelegate: class {
    
    func serviceTapped(service: ServiceData, collectionViewTag: Int?)
 }

class NewHomeCell: BaseTableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: NewHomeCellDelegate?
    
    var newList:[ServiceData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.registerCellNib(ServiceCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setData(_ data: Any?) {
    }
    
    func setList(dict:[String:Any]) {
        
        lblTitle.text = dict["title"] as? String
        newList = (dict["list"] as? [ServiceData])!
        
        if newList.count > 3 {
            
            newList.insert(ServiceData(productID: "0", title: "More"), at: 3)
        }
        collectionView.reloadData()
    }
}
 
 extension NewHomeCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if newList.count > 3 {
            return 4
        }
        else {
            return newList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCell.identifier, for: indexPath) as! ServiceCell
    
        cell.setData(data: newList[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 160, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tappedData = newList[indexPath.row]
        delegate?.serviceTapped(service: tappedData, collectionViewTag: self.tag)
    }
 }
 
