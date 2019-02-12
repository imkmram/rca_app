//
//  SelectedImageVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 22/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import UIKit
import SVProgressHUD

class SelectedImageVC: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblDocument: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblCountry: UILabel!
    
    var country:String!
    var document: Document!
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.layer.cornerRadius = 8
        bottomView.layer.cornerRadius = 8
        
        lblCountry.text = country
        lblDocument.text = document.doc_name ?? "-"
        imgView.image = selectedImage
        
       // imgView.image = UIImage(named: "closedeyes.jpg")
        // imgView.image = UIImage(named: "pancard.jpg")
        //imgView.image = UIImage(named: "passport.jpg")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnProcessTapped(_ sender: Any) {

        let imgProcessor = ImageProcess()
        
        let result = imgProcessor.getImage(image: imgView.image!)
        
        if let finalImage = result.croppedImage  {
            let resultVC = storyboard?.instantiateViewController(withIdentifier: "NewResultVC") as! NewResultVC
            resultVC.image = finalImage
            resultVC.size = document.size
            resultVC.document = document

            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        else {
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "ERROR......", message: result.error, preferredStyle: .alert)

            let actionOK = UIAlertAction(title: "OK", style: .default) { (handler) in
                self.navigationController?.popViewController(animated: true)
            }
            let actionCANCEL = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alert.addAction(actionOK)
            alert.addAction(actionCANCEL)

            self.present(alert, animated: true, completion: nil)
        }
    }
}
