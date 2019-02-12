//
//  HomeVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 27/11/18.
//  Copyright © 2018 IntelligentBee. All rights reserved.
//

import UIKit
import Crashlytics

class HomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btnView: UIStackView!
    @IBOutlet weak var tblDocument: UITableView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var btnDocument: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    
    var selectedCountry: Country?
    var selectedDocument: Document?
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblDocument.register(UINib(nibName: "DocumentCell", bundle: nil), forCellReuseIdentifier: "DocumentCell")
        
        btnDocument.isHidden = true
        viewDetail.isHidden = true
        btnView.isHidden = true
        tblDocument.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Visa Photo"
        
        let btnGalleryView = UIBarButtonItem(image: #imageLiteral(resourceName: "gallery"), style: .plain, target: self, action: #selector(btnGalleryViewTapped))
        self.navigationItem.setRightBarButton(btnGalleryView, animated: true)
    }
    
    @objc func btnGalleryViewTapped() {
        
      //  Crashlytics.sharedInstance().crash()
        
        let galleryVC = self.storyboard?.instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
        self.navigationController?.pushViewController(galleryVC, animated: true)
    }
    
    @IBAction func btnCountryTapped(_ sender: Any) {
        
        btnDocument.titleLabel?.text = "Select Document"
        btnDocument.isHidden = true
        viewDetail.isHidden = true
        
        let countryVC = self.storyboard?.instantiateViewController(withIdentifier: "CountryVC") as! CountryVC
        countryVC.delegate = self
        self.navigationController?.pushViewController(countryVC, animated: true)
    }
    
    @IBAction func btnDocumentTapped(_ sender: Any) {
        
        let documentVC =  self.storyboard?.instantiateViewController(withIdentifier: "DocumentVC") as! DocumentVC
        documentVC.delegate = self
        documentVC.selectedCountry = selectedCountry
        self.navigationController?.pushViewController(documentVC, animated: true)
    }
    
    @IBAction func btnCameraTapped(_ sender: Any) {
        
        if let _ = selectedDocument {
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
                
            }
            else {
                let alert = UIAlertController(title: "Message", message: "NO CAMERA", preferredStyle: .alert)
                let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(actionOK)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            let alert = UIAlertController(title: "Message", message: "Select a document to continue", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnGalleryTapped(_ sender: Any) {
        
        if let _ = selectedDocument {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
            
        }
        else {
            let alert = UIAlertController(title: "Message", message: "Select a document to continue", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnUploadTapped(_ sender: Any) {
        
//        if let _ = selectedDocument {
//            actionSheet()
//        }
//        else {
//                let alert = UIAlertController(title: "Message", message: "Select a document to continue", preferredStyle: .alert)
//            let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alert.addAction(actionOK)
//
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    func actionSheet() {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in
//                picker.sourceType = .camera
//                self.present(picker, animated: true, completion: nil)
//            }))
//        }
//        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
//            picker.sourceType = .photoLibrary
//            // on iPad we are required to present this as a popover
//            if UIDevice.current.userInterfaceIdiom == .pad {
//                picker.modalPresentationStyle = .popover
//                picker.popoverPresentationController?.sourceView = self.view
//                //picker.popoverPresentationController?.sourceRect = self.takePhotoButton.frame
//            }
//            self.present(picker, animated: true, completion: nil)
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        // on iPad this is a popover
//        alert.popoverPresentationController?.sourceView = self.view
//        //alert.popoverPresentationController?.sourceRect = takePhotoButton.frame
//        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        let capturedImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let image = rotateImage(image: capturedImage)
        
        //performSegue(withIdentifier: "showImageSegue", sender: self)
        
//        let imgProcessor = ImageProcess()
//        let finalImage = imgProcessor.getImage(image: image)
//
//        let resultVC = storyboard?.instantiateViewController(withIdentifier: "NewResultVC") as! NewResultVC
//        resultVC.image = finalImage
//        resultVC.size = selectedDoc.size
        
        let selectedImageVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectedImageVC") as! SelectedImageVC
        selectedImageVC.country = selectedCountry?.name
        selectedImageVC.document = selectedDocument
        selectedImageVC.selectedImage = image

        self.navigationController?.pushViewController(selectedImageVC, animated: true)
    }
    
    func rotateImage(image: UIImage) -> UIImage {
        
        if (image.imageOrientation == UIImageOrientation.up ) {
            return image
        }
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return copy ?? image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeVC : CountryVCDelegate, DocumentVCDelegate {
  
    func selectedCountry(country: Country) {
        selectedRow = nil
        selectedDocument = nil
        selectedCountry = country
        btnCountry.setTitle(country.name, for: .normal)
       // btnDocument.isHidden = false
        tblDocument.isHidden = false
        btnView.isHidden = false
        tblDocument.reloadData()
    }

    func selectedDocument(document: Document) {
//        viewDetail.isHidden = false
//        btnView.isHidden = false
//
//        selectedDocument = document
//
//        btnDocument.setTitle(document.name, for: .normal)
//
//        if let width = document.size?.width, let height = document.size?.height {
//            lblSize.text = String(format: "%.2f INCH x %.2f INCH", arguments: [width, height])
//        }
    }
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedCountry?.document?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell") as! DocumentCell
        cell.selectionStyle = .none
        
        if let row = selectedRow {
            if row == indexPath.row {
                cell.innerRadioView.backgroundColor = UIColor.black
            }
            else {
                cell.innerRadioView.backgroundColor = UIColor.white
            }
        }
        else {
             cell.innerRadioView.backgroundColor = UIColor.white
        }
        
        if let docs = selectedCountry?.document {
            cell.setData(data: docs[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return 265
        return 133
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedDocument = selectedCountry?.document![indexPath.row]
        selectedRow = indexPath.row
        tableView.reloadData()
    }
}
