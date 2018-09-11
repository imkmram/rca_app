//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        
        //self.addLeftBarButtonWithImage(UIImage(named: "menu_icon")!)
        
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu_icon"))
        
        //self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    func setBackTitle(title:String) {
        let backItem = UIBarButtonItem()
        backItem.title = title
        navigationItem.backBarButtonItem = backItem
    }
    
    public func addRightNavigationView() {
        
         let rightNavView = RightNavigationView().loadNib()
        rightNavView.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        
        let rightButtons: UIBarButtonItem = UIBarButtonItem(customView: rightNavView)
        navigationItem.rightBarButtonItem = rightButtons
    }
    
}
