//
//  Custom.swift
//  FaceVision
//
//  Created by Ashok Gupta on 23/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import Foundation
import Photos

protocol CustomPhotoAlbumDelegate:class {
    func result(flag:Bool, error:Error?)
}

@objc class CustomPhotoAlbum: NSObject {
    
    weak var delegate: CustomPhotoAlbumDelegate?
    
    var galleryImages = [Image]()
    
    /// Default album title.
    static let defaultTitle = "SELVI"
    
    /// Singleton
    static let shared = CustomPhotoAlbum(CustomPhotoAlbum.defaultTitle)
    
    /// The album title to use.
    private(set) var albumTitle: String
    
    /// This album's asset collection
    internal var assetCollection: PHAssetCollection?
    
    /// Initialize a new instance of this class.
    ///
    /// - Parameter title: Album title to use.
    init(_ title: String) {
        self.albumTitle = title
        super.init()
    }
    
    /// Save the image to this app's album.
    ///
    /// - Parameter image: Image to save.
    public func save(_ image: UIImage?, _ document: Document?) {
        guard let image = image else { return }
        
        // Request authorization and create the album
        requestAuthorizationIfNeeded { (_) in
            
            // If it all went well, we've got our asset collection
            guard let assetCollection = self.assetCollection else { return }
            
            PHPhotoLibrary.shared().performChanges({
                
                // Make sure that there's no issue while creating the request
                let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                guard let placeholder = request.placeholderForCreatedAsset,
                    let albumChangeRequest = PHAssetCollectionChangeRequest(for: assetCollection) else {
                        return
                }
                
                let enumeration: NSArray = [placeholder]
                albumChangeRequest.addAssets(enumeration)
                
            }, completionHandler: { (flag, error) in
                //print("Hello")
                if flag {
                    let fetchOptions = PHFetchOptions()
                    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                    
                    let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions).firstObject
                    // print(fetchResult)
                    
                    let savedImage = Image(doc_id: document?.doc_id, doc_name: document?.doc_name, doc_size: (document?.doc_size)!, image_identifier: fetchResult?.localIdentifier)
                    
                    UserDefaults.standard.setSavedImage(value: savedImage)
                }
                self.delegate?.result(flag: flag, error: error)
            })
        }
    }
}

internal extension CustomPhotoAlbum {
    
    /// Request authorization and create the album if that went well.
    ///
    /// - Parameter completion: Called upon completion.
    func requestAuthorizationIfNeeded(_ completion: @escaping ((_ success: Bool) -> Void)) {
        
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                completion(false)
                return
            }
            
            // Try to find an existing collection first so that we don't create duplicates
            if let collection = self.fetchAssetCollectionForAlbum() {
                self.assetCollection = collection
                completion(true)
                
            } else {
                self.createAlbum(completion)
            }
        }
    }
    
    
    /// Creates an asset collection with the album name.
    ///
    /// - Parameter completion: Called upon completion.
    func createAlbum(_ completion: @escaping ((_ success: Bool) -> Void)) {
        
        PHPhotoLibrary.shared().performChanges({
            
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: self.albumTitle)
            
        }) { (success, error) in
            defer {
                completion(success)
            }
            
            guard error == nil else {
                print("error \(error!)")
                return
            }
            
            self.assetCollection = self.fetchAssetCollectionForAlbum()
        }
    }
    
    
    /// Fetch the asset collection matching this app's album.
    ///
    /// - Returns: An asset collection if found.
    func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", self.albumTitle )
        
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        return collection.firstObject
    }
    
    func fetchCustomAlbumPhotos() {
        
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult<AnyObject>()
        let fetchOptions = PHFetchOptions()
        
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.defaultTitle)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let firstObject = collection.firstObject{
            //found the album
            assetCollection = firstObject
            albumFound = true
        }
        else { albumFound = false }
        
        _ = collection.count
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        photoAssets = PHAsset.fetchAssets(in: assetCollection, options: fetchOption) as! PHFetchResult<AnyObject>
        let imageManager = PHCachingImageManager()
        
        galleryImages.removeAll()
        
        photoAssets.enumerateObjects{(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                print("Inside  If object is PHAsset, This is number 1")
                
                let imageSize = CGSize(width: asset.pixelWidth,
                                       height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset,
                                          targetSize: imageSize,
                                          contentMode: .aspectFill,
                                          options: options,
                                          resultHandler: {
                                            (image, info) -> Void in
                                            let photo = image!
                                            /* The image is now available to us */
                                            self.addImgToArray(uploadImage: photo, identifier: asset.localIdentifier)
                                            print("enum for image, This is number 2")
                })
            }
        }
    }
    
    func addImgToArray(uploadImage:UIImage, identifier: String) {
        
        let gallery = UserDefaults.standard.getSavedImages()
        
//                 let contains = gallery?.images?.contains(where: { (object) -> Bool in
//                   if object.image_identifier == identifier {
//                        return true
//                    }
//                    else {
//                     //UserDefaults.standard.removeSavedImage(idenfifier: identifier)
//                        return false
//                    }
//                })
        
         // if contains! {
        let result = gallery?.images?.filter({ (object) -> Bool in
            if object.image_identifier == identifier {
                return true
            }
            return false
        })
        
        if var galleryObject = result?.first {
            galleryObject.image = UIImageJPEGRepresentation(uploadImage, 1.0)
            self.galleryImages.append(galleryObject)
        }
      //  }
    }
}
