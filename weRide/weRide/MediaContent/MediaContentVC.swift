//
//  MediaContentVC.swift
//  weRide
//
//  Created by Ashok Gupta on 22/10/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class MediaContentVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tblMessage: UITableView!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCollection: UICollectionView!
    
    //MARK:- Member Variables
    var wayPointData:Waypoints!
    var comments:[String] = []
    var maxHeight: CGFloat = 0.0
    var imageList:[String] = []
    var presenter: MediaContentPresenter = MediaContentPresenter()

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgCollection.register(UINib(nibName: "ImgCell", bundle: nil), forCellWithReuseIdentifier: "ImgCell")
        maxHeight = tblHeight.constant
         tblHeight.constant = CGFloat(comments.count * 44)
        comments.append("Great")
        comments.append("Execellent")
        
        imageList.append("Goa1.jpg")
        imageList.append("Goa1.jpg")
        imageList.append("Goa1.jpg")
        imageList.append("Goa1.jpg")
        imageList.append("Goa1.jpg")
        imageList.append("Goa1.jpg")
        
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let camera = UIBarButtonItem(image: #imageLiteral(resourceName: "camera"), style: .done, target: self, action: #selector(takePhoto))
      //  let gallery = UIBarButtonItem(image: #imageLiteral(resourceName: "gallery"), style: .done, target: self, action: #selector(btnGalleryTapped))
        
        navigationItem.setRightBarButtonItems([camera], animated: true)
        
      //  if let data = wayPointData {
            self.navigationItem.title = wayPointData.waypoint_location_name
            presenter.getData(wayID: wayPointData.way_point_id ?? "")
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Event
    @IBAction func btnSendTapped(_ sender: UIButton) {
        
        if let message = txtMessage.text, txtMessage.text?.length != 0 {
            presenter.addComment(wayID: wayPointData.way_point_id ?? "", comment: message)
        }
    }
    
    @objc func takePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
            }))
        }
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            picker.sourceType = .photoLibrary
            // on iPad we are required to present this as a popover
            if UIDevice.current.userInterfaceIdiom == .pad {
                picker.modalPresentationStyle = .popover
                picker.popoverPresentationController?.sourceView = self.view
              //  picker.popoverPresentationController?.sourceRect = self.takePhotoButton.frame
            }
            self.present(picker, animated: true, completion: nil)
            
            if #available(iOS 11.0, *) {
                picker.navigationBar.barTintColor = UIColor(named: "BaseColor")
            } else {
                // Fallback on earlier versions
                // imagePicker.navigationBar.tintColor = UIColor(red: 252, green: 163, blue: 17, alpha: 1.0)
                picker.navigationBar.tintColor = UIColor.black
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // on iPad this is a popover
        alert.popoverPresentationController?.sourceView = self.view
       // alert.popoverPresentationController?.sourceRect = takePhotoButton.frame
        self.present(alert, animated: true, completion: nil)
    }
    
//    @objc private func  btnCameraTapped() {
//
//            #if targetEnvironment(simulator)
//                print("For Camera run on device")
//            #else
//                let cameraVC = UIImagePickerController()
//                cameraVC.sourceType = .camera
//                cameraVC.modalPresentationStyle = .currentContext
//                if #available(iOS 11.0, *) {
//                    cameraVC.navigationBar.barTintColor = UIColor(named: "BaseColor")
//                } else {
//                    // Fallback on earlier versions
//                    cameraVC.navigationBar.tintColor = UIColor(red: 252, green: 163, blue: 17, alpha: 1.0)
//        }
//                cameraVC.delegate = self
//                self.present(cameraVC, animated: true, completion: nil)
//            #endif
//    }
//    @objc private func btnGalleryTapped() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.modalPresentationStyle = .currentContext
//        if #available(iOS 11.0, *) {
//            imagePicker.navigationBar.barTintColor = UIColor(named: "BaseColor")
//        } else {
//            // Fallback on earlier versions
//           // imagePicker.navigationBar.tintColor = UIColor(red: 252, green: 163, blue: 17, alpha: 1.0)
//        imagePicker.navigationBar.tintColor = UIColor.black
//        }
//        imagePicker.delegate = self
//        self.present(imagePicker, animated: true, completion: nil)
//    }
}

//MARK:- UICollectionViewDataSource
extension MediaContentVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageList.count == 5 {
            return 5
        }
        else if imageList.count > 5 {
            return 6
        }
        else {
            return imageList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCell", for: indexPath) as! ImgCell
        
        if indexPath.row == 5 {
            cell.imgThumbnail.image = #imageLiteral(resourceName: "more")
        }
        else {
            cell.imgThumbnail.image = #imageLiteral(resourceName: "Goa1.jpg")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            let listingVC = Utils.startRideStoryboardController(identifier: Constant.kMoreMediaListing_VC) as! MoreMediaListingVC
            listingVC.imageList = imageList
            self.navigationController?.pushViewController(listingVC, animated: true)
        }
    }
}

//MARK:- UITableViewDataSource
extension MediaContentVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tblHeight.constant == 0 {
            tblHeight.constant = tableView.contentSize.height
        }
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        cell?.textLabel?.text = comments[indexPath.row]
        
        return cell!
    }
}

extension MediaContentVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    }
}

extension MediaContentVC : MediaContentVIew {
    func updateCommentList() {
        comments.append(txtMessage.text!)
        txtMessage.text = ""
        tblHeight.constant = CGFloat(comments.count * 44)
        DispatchQueue.main.async {
            self.tblMessage.needsUpdateConstraints
            self.tblMessage.reloadData()
            if self.tblHeight.constant >= self.maxHeight {
                self.tblMessage.scrollToRow(at: IndexPath(row: self.comments.count - 1, section: 0), at: .top, animated: true)
            }
        }
    }
    
    func updateImaggeListList() {
    }
    
    func updateList() {
    }
    
    func setList(list: [Result_set]) {
        
    }
    
    func showMessage(message: CustomError, title: String, reCall: Bool) {
    }
}
