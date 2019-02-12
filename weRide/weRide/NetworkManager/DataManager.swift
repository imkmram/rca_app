//
//  DataManager.swift
//  RCA
//
//  Created by TWC on 31/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

public class DataManager {
    
    private var session:URLSession!
    public var task :URLSessionDataTask?
    private var downloadTask: URLSessionDownloadTask?
   
    var bytesExpected:Int64 {
        return downloadTask?.countOfBytesExpectedToReceive ?? 0
    }
    
   public var taskState: URLSessionTask.State? {
        return task?.state
    }
    
    init() {
    }
    
    private func postData(parameter:[String:Any]?) -> Data? {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameter!, options: .prettyPrinted)

            let theJSONText = String(data: data, encoding: .utf8)
           
//                let theJSONText = String(data: theJSONData,
//                                         encoding: String.Encoding.utf8) {
            print("REQUEST PARAMETER = \n \(String(describing: theJSONText))")
            return data
        } catch  {
            return nil
        }
    }
    
    public func getData(requestType: String, url: URL, parameter: [String:Any]?, completion:@escaping (Data?, Error?) -> Void) {
        
        if NetworkManager.shared.isNetworkAvailable {
            
            session = URLSession(configuration: .default)
            
            let request = NSMutableURLRequest(url: url,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 90.0)
            request.httpMethod = requestType
            
             var body = Data()
            if let param = parameter {
                body = postData(parameter: param)!
            }
           request.httpBody = body
            let postLength = String(format: "%lu", UInt(body.count))
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            
            task =  session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                self.session = nil
                guard error == nil else {
                    print("Returned Error....\(String(describing: error?.localizedDescription))")
                    completion(nil, CustomError.OtherError)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if let content = data  {
                        
                        if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 {
                            print(content)
                            
                            do {
                                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                                print("RESPONSE: \(json)")
                            }
                            catch {
                                print("Caught")
                            }
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
        }
        else {
            completion(nil, CustomError.NoNetwork)
        }
    }
    
    public func getDataWithImage(requestType: String, url: URL, _params: [String:Any], imgData: Data?,  completion:@escaping (Data?, Error?) -> Void) {
        
        if NetworkManager.shared.isNetworkAvailable {
            
            let session:URLSession = URLSession(configuration: .default)
            let task :URLSessionDataTask?
            
            let requestURL = url
            let request = NSMutableURLRequest(url: requestURL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 90.0)
            
            let BoundaryConstant = "----------V2ymHFg03ehbqgZCaKO6jy"
            let FileParamConstant = "file"
            
            let contentType = "multipart/form-data; boundary=\(BoundaryConstant)"
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
            var body = Data()
            
            for param  in _params.keys {
                
                if let enCoding = "--\(BoundaryConstant)\r\n".data(using: .utf8) {
                    body.append(enCoding)
                }
                if let enCoding = "Content-Disposition: form-data; name=\"\(param )\"\r\n\r\n".data(using: .utf8) {
                    body.append(enCoding)
                }
                if let value = _params[param], let enCoding = "\(value)\r\n".data(using: .utf8) {
                    body.append(enCoding)
                }
            }
            
            if let _imgData = imgData {
            
          //  if imgData != nil {
                if let enCoding = "--\(BoundaryConstant)\r\n".data(using: .utf8) {
                    body.append(enCoding)
                }
                
                if let enCoding = "Content-Disposition: form-data; name=\"\(FileParamConstant)\"; filename=\"image.png\"\r\n".data(using: .utf8) {
                    body.append(enCoding)
                }
                
                if let enCoding = "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
                    body.append(enCoding)
                }
                body.append(_imgData)
                if let enCoding = "\r\n".data(using: .utf8) {
                    body.append(enCoding)
                }
            }
            
            if let enCoding = "--\(BoundaryConstant)--\r\n".data(using: .utf8) {
                body.append(enCoding)
            }
            
            request.httpBody = body
            let postLength = String(format: "%lu", UInt(body.count))
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            request.httpMethod = "POST"
            
            task =  session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                guard error == nil else {
                    print("Returned Error....\(String(describing: error?.localizedDescription))")
                    // completion(nil, CustomError.OtherError)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if let content = data  {
                        
                        if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 {
                            print(content)
                            
                            do {
                                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                                print("RESPONSE: \(json)")
                            }
                            catch {
                                print("Caught")
                            }
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
        }
    }
    
    public func requestGET(requestType: String, url: URL, completion:@escaping (Data?, Error?) -> Void) {
        
        if NetworkManager.shared.isNetworkAvailable {
            
            let request = NSMutableURLRequest(url: url,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 90.0)
            request.httpMethod = requestType
            
//            var body = Data()
//            if let param = parameter {
//                body = postData(parameter: param)!
//            }
//            request.httpBody = body
//            let postLength = String(format: "%lu", UInt(body.count))
//            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            
            
            session = URLSession(configuration: .default)
            
            task =  session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                guard error == nil else {
                    print("Returned Error....\(String(describing: error?.localizedDescription))")
                    completion(nil, CustomError.OtherError)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if let content = data  {
                        
                        if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 {
                            print(content)
                            
                            do {
                                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                                print("RESPONSE: \(json)")
                            }
                            catch {
                                print("Caught")
                            }
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
        }
        else {
            completion(nil, CustomError.NoNetwork)
        }
    }
    
    
//    public static func getData(url:URL, completion:@escaping (Data?, Error?)->Void){
//
//        if NetworkManager.shared.isNetworkAvailable {
//
//            task = session.dataTask(with: url) { (data, response, error) in
//
//                guard error == nil else {
//                    print("Returned Error....\(String(describing: error?.localizedDescription))")
//                    completion(nil, CustomError.OtherError)
//                    return
//                }
//
//                if let httpResponse = response as? HTTPURLResponse {
//
//                    if let content = data  {
//
//                        if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 {
//                            print(content)
//                            completion(data,nil)
//                        }
//                        else if httpResponse.statusCode >= 400 && httpResponse.statusCode <= 500 {
//                            // Client Error
//                            completion(nil, CustomError.BadRequest)
//                        }
//                        else {
//                            // Server Error
//                            completion(nil, CustomError.InternalServerError)
//                        }
//                    }
//                    else {
//                        completion(nil, CustomError.OtherError)
//                        return
//                    }
//                }
//            }
//
//            task?.resume()
//        }
//        else {
//            completion(nil, CustomError.NoNetwork)
//        }
//    }
    
    private func getLocalDirectory() -> URL? {
    
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
    
    public func downloadFile(fileName:String, url:URL) {
        
        downloadTask = session.downloadTask(with: url, completionHandler: { (_location, _response, _error) in
            
            if _error == nil {
                
                guard  let location = _location, var folderPath = self.getLocalDirectory() else {
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
        
//        let state :URLSessionTask.State = (task?.state)!
//
//        //task?.resume()
//        switch state {
//        case .running:
//              debugPrint("No Nothing")
//           // task?.suspend()
//        case .suspended:
//            task?.resume()
//        case .canceling:
//            debugPrint("No Nothing")
//        case .completed:
//            task?.resume()
//            debugPrint("Call completed, do nothing")
//        }
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
