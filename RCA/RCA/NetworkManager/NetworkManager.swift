//
//  NetworkManager.swift
//  RCA
//
//  Created by TWC on 26/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import ReachabilitySwift

public protocol NetworkStatusListener:class {
    
    func networkStatusDidChanged(status:Reachability.NetworkStatus)
}

class NetworkManager: NSObject {
    
     static let shared = NetworkManager()  // 2. Shared instance
    
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    // 5. Reachibility instance for Network status monitoring
    let reachability = Reachability()!
    
    var listeners = [NetworkStatusListener]()
    
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        
        switch reachability.currentReachabilityStatus {
            
        case .notReachable:
            debugPrint("Network became unreachable")
            
            reachabilityStatus = .notReachable
          
        case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
            
            reachabilityStatus = .reachableViaWiFi
           
        case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
            
             reachabilityStatus = .reachableViaWWAN
        }
        
        for listener in listeners {
            
            listener.networkStatusDidChanged(status: reachability.currentReachabilityStatus)
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
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
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification,
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
