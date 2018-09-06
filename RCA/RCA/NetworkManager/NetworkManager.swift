//
//  NetworkManager.swift
//  RCA
//
//  Created by TWC on 26/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

public protocol NetworkStatusListener:class {
    func networkStatusDidChanged(status:Reachability.Connection)
}

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()  // 2. Shared instance
    
     let reachability = Reachability()!
    
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .none
    }
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
     var reachabilityStatus: Reachability.Connection = .none
    
    // 5. Reachibility instance for Network status monitoring
   
    var listeners = [NetworkStatusListener]()
    
    override init() {
        reachabilityStatus = reachability.connection
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        
        switch reachability.connection {
            
            case .none:
                debugPrint("Network became unreachable")
                reachabilityStatus = .none
            case .wifi:
                debugPrint("Network reachable through WiFi")
                reachabilityStatus = .wifi
            case .cellular:
                debugPrint("Network reachable through Cellular Data")
                reachabilityStatus = .cellular
            }
        
        for listener in listeners {
            listener.networkStatusDidChanged(status: reachability.connection)
        }
    }
    
//    func isConnected() -> Bool {
//
//        if isNetworkAvailable{
//            return true
//        }
//        else{
//            return false
//        }
//    }
    
    //Starts monitoring the network availability status
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    
    func addListener(listener:NetworkStatusListener) {
        listeners.append(listener)
    }
    
    func removeListener(listener:NetworkStatusListener) {
         listeners = listeners.filter({ (value) -> Bool in
            value !== listener
        })
    }
}
