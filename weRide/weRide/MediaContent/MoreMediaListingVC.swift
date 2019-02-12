//
//  MoreMediaListingVC.swift
//  weRide
//
//  Created by Ashok Gupta on 29/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class MoreMediaListingVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var imgCollection: UICollectionView!
    
    //MARK:- Member Variables
    var imageList:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgCollection.register(UINib(nibName: "ImgCell", bundle: nil), forCellWithReuseIdentifier: "ImgCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension MoreMediaListingVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCell", for: indexPath) as! ImgCell
        
            cell.imgThumbnail.image = UIImage(named: imageList[indexPath.row] as String)
    
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth: CGFloat = (imgCollection.bounds.width - 30) / 2
        let cellHeight: CGFloat = (2 * cellWidth) / 3
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
