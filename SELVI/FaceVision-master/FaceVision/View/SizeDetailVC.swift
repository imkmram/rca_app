//
//  SizeDetailVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 28/11/18.
//  Copyright © 2018 IntelligentBee. All rights reserved.
//

import UIKit

class SizeDetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tblSize: UITableView!
    
    var selectedCountry:Country!
    var selectedDoc:Document!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func actionSheet() {
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
                //picker.popoverPresentationController?.sourceRect = self.takePhotoButton.frame
            }
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // on iPad this is a popover
        alert.popoverPresentationController?.sourceView = self.view
        //alert.popoverPresentationController?.sourceRect = takePhotoButton.frame
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        let capturedImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
       let image = rotateImage(image: capturedImage)
        
       //performSegue(withIdentifier: "showImageSegue", sender: self)
        
        let imgProcessor = ImageProcess()
        let result = imgProcessor.getImage(image: image)
        
        let resultVC = storyboard?.instantiateViewController(withIdentifier: "NewResultVC") as! NewResultVC
        resultVC.image = result.croppedImage
        resultVC.size = selectedDoc.size
        
        self.navigationController?.pushViewController(resultVC, animated: true)
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
