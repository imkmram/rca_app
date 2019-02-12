//
//  GalleryVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 05/02/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {
    
    var list = [Image]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let systemGallery = CustomPhotoAlbum.shared
        systemGallery.fetchCustomAlbumPhotos()
        list = systemGallery.galleryImages
        
        UserDefaults.standard.removeAllSavedImage()
        
        for object in list {
            
            let newObject = Image(doc_id: object.doc_id!, doc_name: object.doc_name!, doc_size: object.doc_size!, image_identifier: object.image_identifier)
            
            UserDefaults.standard.setSavedImage(value: newObject)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Gallery"
    }
}

extension GalleryVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        
        if let imgData = list[indexPath.row].image {
            if let img = UIImage(data: imgData) {
                cell.imgView.image = img
            }
        }
        
        cell.lblDocName.text = list[indexPath.row].doc_name!
        cell.lblDocSize.text = list[indexPath.row].doc_size!
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenWith: CGFloat = self.view.bounds.width
        let cellWidth: CGFloat = (screenWith - 40) / 2

        return CGSize(width: cellWidth, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let data = list[indexPath.row]
        if let imgData = data.image {
            let img = UIImage(data: imgData)!
            let activity = UIActivityViewController(activityItems: [img], applicationActivities: nil)
            self.present(activity, animated: true, completion: nil)
        }
    }
}
