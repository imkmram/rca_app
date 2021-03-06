//
//  DataManager.swift
//  RCA
//
//  Created by TWC on 31/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

enum CustomError : Error {
    case NoNetwork
    case BadRequest
    case InternalServerError
    case OtherError
    
    var localizedDescription: String {
        
        switch self {
        case .NoNetwork:
            return NSLocalizedString("No Network, check your connection", comment: "Custom Error")
        case .BadRequest:
            return NSLocalizedString("Request error, try later", comment: "Custom Error")
        case .InternalServerError:
            return NSLocalizedString("Server not responding, try later", comment: "Custom Error")
        case .OtherError:
            return NSLocalizedString("Something went wrong", comment: "Custom Error")
        }
    }
}

public struct DataManager {
    
    private static var session:URLSession = URLSession(configuration: .default)
    private static var task :URLSessionDataTask?
    private static var downloadTask: URLSessionDownloadTask?
   
    static var bytesExpected:Int64 {
        return downloadTask?.countOfBytesExpectedToReceive ?? 0
    }
    
    init() {
    }
    
    public static func getData(url:URL, completion:@escaping (Data?, Error?)->Void){
        
      //  if NetworkManager.shared.isNetworkAvailable {
            
            task = session.dataTask(with: url) { (data, response, error) in
                
                guard error == nil else {
                    print("Returned Error....\(String(describing: error?.localizedDescription))")
                    completion(nil, CustomError.NoNetwork)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if let content = data  {
                        
                        if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 {
                            print(content)
                            completion(data,nil)
                        }
                        else if httpResponse.statusCode >= 400 && httpResponse.statusCode <= 500 {
                            // Client Error
                            completion(nil, CustomError.BadRequest)
                        }
                        else {
                            // Server Error
                            completion(nil, CustomError.InternalServerError)
                        }
                    }
                    else {
                        completion(nil, CustomError.OtherError)
                        return
                    }
                }
            }
            
            task?.resume()
//        }
//        else {
//            completion(nil, CustomError.NoNetwork)
//        }
    }
    
    private static func getLocalDirectory() -> URL? {
    
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentPath = paths.first
        
        let directoryPath = documentPath?.appendingPathComponent("Downloads")
        
        guard let path = directoryPath else {
            return nil
        }
        
        if !FileManager.default.fileExists(atPath: path.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: path, withIntermediateDirectories: false, attributes: nil)
            }catch {
                
            }
        }
        return path
    }
    
    public static func downloadFile(fileName:String, url:URL) {
        
        downloadTask = session.downloadTask(with: url, completionHandler: { (_location, _response, _error) in
            
            if _error == nil {
                
                guard  let location = _location, var folderPath = getLocalDirectory() else {
                    return
                }
                
                folderPath = folderPath.appendingPathComponent("image1")
                folderPath.appendPathExtension(".jpg")
                
                do {
                  try FileManager.default.moveItem(at: location, to: folderPath)
                }catch {
                    
                }
            }
        })
        
        downloadTask?.resume()
    }

   static func reload(){
        
        let state :URLSessionTask.State = (task?.state)!

        //task?.resume()
        switch state {
        case .running:
              debugPrint("No Nothing")
           // task?.suspend()
        case .suspended:
            task?.resume()
        case .canceling:
            debugPrint("No Nothing")
        case .completed:
            task?.resume()
            debugPrint("Call completed, do nothing")
        }
    }
    
    func pause(){
//        let state :URLSessionTask.State = (task?.state)!
//
//        task?.suspend()
//        switch state {
//        case .running:
//            task?.suspend()
//        case .suspended:
//            debugPrint("No Nothing")
//            //task?.resume()
//        case .canceling:
//            debugPrint("No Nothing")
//        case .completed:
//            debugPrint("Call completed, do nothing")
//        }
    }
}
