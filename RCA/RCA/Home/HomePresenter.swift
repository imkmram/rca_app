//
//  HomePresenter.swift
//  RCA
//
//  Created by TWC on 26/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

class HomePresenter:BasePresenter {
    
  weak private var homeView :HomeView?
    private lazy var dataManager:DataManager = DataManager()
    
    func attachView(view:HomeView) {
        homeView = view
    }
    
    func detachView() {
        homeView = nil
    }
    
    override func getData(strURL:String) {
        
        
        homeView?.startLoading()
        
        guard  let url = URL(string: strURL) else {
            return
        }
        
        let list :[String] = ["One", "Two", "Three"]
        
        dataManager.getData(url: url) { (data, error) in
            
        }
        
        if(list.count > 0){
            homeView?.setData(data: list)
        }
        else{
            homeView?.emptyList()
        }
        
        homeView?.stopLoading()
    }
    
    func reloadDataCall() {
        dataManager.reload()
    }
}
