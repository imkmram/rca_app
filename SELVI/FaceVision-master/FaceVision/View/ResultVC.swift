//
//  ResultVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 12/11/18.
//  Copyright © 2018 IntelligentBee. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    var image:UIImage!
    var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drawImageCell(length: 1.5, breath: 0)
      //  physicalPhoneSize()
    }

    func drawImageCell(length:CGFloat, breath:CGFloat) {
        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
       // let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        
        let ppi = screenScale * ((UIDevice.current.userInterfaceIdiom == .pad) ? 132 : 163)
        let size = (length / 2.54) * ppi
        
        let width = UIScreen.main.bounds.size.width * screenScale
        let height = UIScreen.main.bounds.size.height * screenScale
        
        let horizontal = width / ppi, vertical = height / ppi;
        
        if imgView != nil {
            imgView.removeFromSuperview()
            imgView = nil
        }
        imgView = UIImageView(frame: CGRect(x: 0, y: 44, width: size, height: size))
        imgView.contentMode = .scaleAspectFit
        self.view.addSubview(imgView)
         imgView.image = image
    }
    
    @IBAction func btnSizeTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            drawImageCell(length: 1.5, breath: 0)
        case 1:
            drawImageCell(length: 1.25, breath: 0)
        case 2:
            drawImageCell(length: 1.0, breath: 0)
        default:
            drawImageCell(length: 1.5, breath: 0)
        }
    }
    
    func getImageWithBackground(image: UIImage, backgroundColor: UIColor)->UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        backgroundColor.setFill()
        //UIRectFill(CGRect(origin: .zero, size: image.size))
        let rect = CGRect(origin: .zero, size: image.size)
        let path = UIBezierPath(arcCenter: CGPoint(x:rect.midX, y:rect.midY), radius: rect.midX, startAngle: 0, endAngle: 6.28319, clockwise: true)
        path.fill()
        image.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func physicalPhoneSize() {
        let scale = UIScreen.main.scale
        
        let ppi = scale * ((UIDevice.current.userInterfaceIdiom == .pad) ? 132 : 163);
        
        let width = UIScreen.main.bounds.size.width * scale
        let height = UIScreen.main.bounds.size.height * scale
        
        let horizontal = width / ppi, vertical = height / ppi;
        
        let diagonal = sqrt(pow(horizontal, 2) + pow(vertical, 2))
        let screenSize = String(format: "%0.1f", diagonal)
        print("Phone Size: \(screenSize)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
