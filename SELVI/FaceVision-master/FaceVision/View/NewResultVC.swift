//
//  NewResultVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 28/11/18.
//  Copyright © 2018 IntelligentBee. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewResultVC: UIViewController {
    
    @IBOutlet weak var lblCopies: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var baseView: UIView!
    
    var image:UIImage?
  //  var imgView: UIImageView!
    var size:Size!
    var document: Document?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCopies.text = "YOU NEED TO PRINT \(String(describing: document?.doc_copies ?? 0)) PHOTOS."
        
        if let _ = image {
            if size.width == 0 || size.height == 0 {
                drawImageCell(width: 2, height: 2)
            }
            else {
                drawImageCell(width: CGFloat(size.width!), height: CGFloat(size.height!))
            }
        }
        else {
            print("No Face Detected")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawImageCell(width:CGFloat, height:CGFloat) {
        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
        // let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        
        let ppi = screenScale * ((UIDevice.current.userInterfaceIdiom == .pad) ? 132 : 163)
        let imgWidth = (width / 2.54) * ppi
        let imgHeight = (height / 2.54) * ppi
        
        let width = UIScreen.main.bounds.size.width * screenScale
        let height = UIScreen.main.bounds.size.height * screenScale
        
        let horizontal = width / ppi, vertical = height / ppi;
        
//        if imgView != nil {
//            imgView.removeFromSuperview()
//            imgView = nil
//        }
//        imgView = UIImageView(frame: CGRect(x: 0, y: 44, width: imgWidth, height: imgHeight))
//        imgView.contentMode = .scaleAspectFit
//        self.view.addSubview(imgView)
//        imgView.image = image
        
        widthConstraint.constant = imgWidth
        heightConstraint.constant = imgHeight
        
        imgView.image = image
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        
        if UserDefaults.standard.isLoggedIn() {
            guard let selectedImage = imgView.image else {
                print("Image not found!")
                return
            }
            
           // CustomPhotoAlbum.shared.save(selectedImage)
            
            // Use a custom album name
            let album = CustomPhotoAlbum("SELVI")
            album.delegate = self
            
            album.save(selectedImage, document)
            
//            UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        else {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    func createFileName() -> String {
        
        let currentDate = Date()
        
        var fileName = "selvi_\(document?.doc_name ?? "Document")_\(document?.doc_size ?? "")_\(currentDate.description)"
        
       fileName = fileName.replacingOccurrences(of: " ", with: "")
        
        return fileName
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            
            let alert = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .cancel) { (action) in
             
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(actionOK)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension NewResultVC : CustomPhotoAlbumDelegate {
    func result(flag: Bool, error: Error?) {
        
        if flag {
            let alert = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
                //self.navigationController?.popToRootViewController(animated: true)
                let galleryVC = self.storyboard?.instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
                let list = self.navigationController?.viewControllers
                
                self.navigationController?.setViewControllers([list![0], galleryVC], animated: true)
                //self.navigationController?.pushViewController(galleryVC, animated: true)
            }
            alert.addAction(actionOK)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            showAlertWith(title: "Save error", message: (error?.localizedDescription)!)
        }
    }
}


