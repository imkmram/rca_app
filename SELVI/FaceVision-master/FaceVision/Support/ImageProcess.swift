//
//  ImageProcess.swift
//  FaceVision
//
//  Created by Ashok Gupta on 28/11/18.
//  Copyright © 2018 IntelligentBee. All rights reserved.
//

import Foundation
import UIKit
import Vision
import SVProgressHUD

class ImageProcess {
    
    var image: UIImage!
    var croppedImage: UIImage?
    var flag:Bool = false
    var message:String?
    
    func getCroppedImage(image:UIImage, completion:@escaping(UIImage, Bool, String) -> Void) {
    }
    
    func getImage(image:UIImage) -> (croppedImage:UIImage?, error:String?) {
        self.image = image
        process()
        
        if !flag {
            return (nil, message)
        }
        else {
            return (croppedImage, nil)
        }
    }    
    func getImageOfSize(image: UIImage, width:CGFloat, height:CGFloat) -> UIImage {
        
        self.image = image
        process()
        
        return croppedImage!
    }
    
    private func process() {
        
        var orientation:Int32 = 0
        var orientationType: CGImagePropertyOrientation!
        
        // detect image orientation, we need it to be accurate for the face detection to work
        switch image.imageOrientation {
        case .up:
            orientation = 1
            orientationType = CGImagePropertyOrientation.up
        case .right:
            orientation = 6
            orientationType = CGImagePropertyOrientation.right
        case .down:
            orientation = 3
            orientationType = CGImagePropertyOrientation.down
        case .left:
            orientation = 8
            orientationType = CGImagePropertyOrientation.left
        default:
            orientation = 1
            orientationType = CGImagePropertyOrientation.up
        }
        
        // vision
        let faceLandmarksRequest = VNDetectFaceLandmarksRequest(completionHandler: self.handleFaceFeatures)
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, orientation: orientationType ,options: [:])
        do {
            try requestHandler.perform([faceLandmarksRequest])
        } catch {
            print(error)
        }
    }
    
    func handleFaceFeatures(request: VNRequest, errror: Error?) {
//        guard let observations = request.results as? [VNFaceObservation] else {
//            fatalError("unexpected result type!")
//        }
        
        if let observations = request.results as? [VNFaceObservation] {
            
            if observations.count > 1 {
                flag = false
                message = "Multiple faces detected. Please upload another image."
            }
            else if observations.count == 1 {
                let face = observations[0]
        
                if face.landmarks?.rightPupil == nil || face.landmarks?.leftPupil == nil {
                    
                    flag = false
                    message = "Closed eyes detected. Please upload another image."
                }
                else if face.landmarks?.leftEye == nil || face.landmarks?.rightEye == nil {
                    flag = false
                    message = "No proper face found in the image. Please upload another image."
                }
                else {
                    addFaceLandmarksToImage(face)
                    flag = true
                    message = nil
                }
            }
            else {
                flag = false
                message = "No proper face found in the image (or image quality is not good enough). Please upload another image."
            }
        }
        else {
            flag = false
            message = "No proper face found in the image (or image quality is not good enough). Please upload another image."
        }
        
       
    }

    func addFaceLandmarksToImage(_ face: VNFaceObservation) {
        
        //face
        UIGraphicsBeginImageContextWithOptions(image.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // draw the image
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        // draw the face rect
        let w = face.boundingBox.size.width * image.size.width
        let h = face.boundingBox.size.height * image.size.height
        let x = face.boundingBox.origin.x * image.size.width
        let y = face.boundingBox.origin.y * image.size.height
        let faceRect = CGRect(x: x, y: y, width: w, height: h)
        
        context?.saveGState()
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(8.0)
        context?.addRect(faceRect)
        context?.drawPath(using: .stroke)
        context?.restoreGState()
        
        // face contour
        context?.saveGState()
        context?.setStrokeColor(UIColor.green.cgColor)
        if let landmark = face.landmarks?.faceContour {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // outer lips
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.outerLips {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // inner lips
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.innerLips {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left eye
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.leftEye {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right eye
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.rightEye {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left pupil
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.leftPupil {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right pupil
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.rightPupil {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // left eyebrow
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.leftEyebrow {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // right eyebrow
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.rightEyebrow {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // nose
        context?.saveGState()
        context?.setStrokeColor(UIColor.purple.cgColor)
        if let landmark = face.landmarks?.nose {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.closePath()
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // nose crest
        context?.saveGState()
        context?.setStrokeColor(UIColor.orange.cgColor)
        if let landmark = face.landmarks?.noseCrest {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        // median line
        context?.saveGState()
        context?.setStrokeColor(UIColor.yellow.cgColor)
        if let landmark = face.landmarks?.medianLine {
            for i in 0...landmark.pointCount - 1 { // last point is 0,0
                let point = landmark.normalizedPoints[i]
                if i == 0 {
                    context?.move(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                } else {
                    context?.addLine(to: CGPoint(x: x + CGFloat(point.x) * w, y: y + CGFloat(point.y) * h))
                    print("Y: \(CGFloat(point.y) * h))")
                }
            }
        }
        context?.setLineWidth(8.0)
        context?.drawPath(using: .stroke)
        context?.saveGState()
        
        calculateRect(face)
        
        // get the final image
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end drawing context
        UIGraphicsEndImageContext()
        
       // imageView.image = finalImage
    }
    
    func calculateRect(_ face: VNFaceObservation) {
        guard let ciImage = CIImage(image: image!) else {
            return
        }
        
        if face.landmarks?.rightPupil?.normalizedPoints.count == 0 || face.landmarks?.leftPupil?.normalizedPoints.count == 0 {
            return
        }
        
        let ciImageSize = ciImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        let w = face.boundingBox.size.width * image.size.width
        let h = face.boundingBox.size.height * image.size.height
        let x = face.boundingBox.origin.x * image.size.width
        let y = face.boundingBox.origin.y * image.size.height
        var faceRect = CGRect(x: x, y: y, width: w, height: h)
        
        // Increase Width and Height keeping the centre point as it is
        let startWidth = faceRect.width
        let startHeight = faceRect.height
        let adjustmentWidth = (startWidth * 1.20) / 2.0
        let adjustmentHeight = (startHeight * 1.20) / 2.0
        faceRect = faceRect.insetBy(dx: -adjustmentWidth, dy:  -adjustmentHeight)
        
         croppedImage = cropImage(image, toRect: faceRect.applying(transform))
    }
    
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect) -> UIImage? {
      
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropRect)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
}

//extension CGRect {
//    func centerAndAdjustPercentage(percentage p: CGFloat) -> CGRect {
//        let x = self.origin.x
//        let y = self.origin.y
//        let w = self.width
//        let h = self.height
//
//        let newW = w * p
//        let newH = h * p
//        let newX = (w - newW) / 2
//        let newY = (h - newH) / 2
//
//        return CGRect(x: newX, y: newY, width: newW, height: newH)
//    }
//}
