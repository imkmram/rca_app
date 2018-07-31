//
//  DataManager.swift
//  RCA
//
//  Created by TWC on 31/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation


public class DataManager {
    
    private lazy var session:URLSession = URLSession(configuration: .default)
    private var task :URLSessionDataTask?
    
    init() {
        
    }
    
    func getData(url:URL, completion:@escaping (Data?, Error?)->Void) {
        
        task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
             
                print("Returned Error....\(String(describing: error?.localizedDescription))")
                completion(nil, error)
                return
            }
            
            guard let content = data else {
                print("No Data")
                 completion(nil, error)
                return
            }
            print(content)
            completion(data,nil)
        }
        
        task?.resume()
    }
    
//    func pause() {
//        task?.suspend()
//    }
//
//    func cancel() {
//        task?.cancel()
//    }
//
//    func resume() {
//        task?.resume()
//    }
    
    func reload(){
        
        let state :URLSessionTask.State = (task?.state)!
        
        switch state {
        case .running:
            task?.suspend()
        case .suspended:
            task?.resume()
        case .canceling:
            debugPrint("No Nothing")
        case .completed:
            debugPrint("Call completed, do nothing")
            
        }
    }
}
