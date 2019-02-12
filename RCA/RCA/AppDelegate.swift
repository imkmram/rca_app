//
//  AppDelegate.swift
//  RCA
//
//  Created by TWC on 25/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate func createMenuView(menu:LeftMenu) {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let leftMenuVC = storyboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
        
        let attributes = [NSAttributedStringKey.font : UIFont(name: "OpenSans-Bold", size: 18)!]
       
        switch menu {
        case .home:
            
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let nvc: UINavigationController = UINavigationController(rootViewController: homeVC)
             leftMenuVC.homeVC = nvc
              nvc.navigationBar.titleTextAttributes = attributes
            let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftMenuVC)
            slideMenuController.automaticallyAdjustsScrollViewInsets = true
            slideMenuController.delegate = homeVC
            self.window?.rootViewController = slideMenuController
            
        case .privacy_policy:
            
             let privacyVC = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
             let nvc: UINavigationController = UINavigationController(rootViewController: privacyVC)
             leftMenuVC.privacyPolicyVC = nvc
             nvc.navigationBar.titleTextAttributes = attributes
             let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftMenuVC)
             slideMenuController.automaticallyAdjustsScrollViewInsets = true
             slideMenuController.delegate = privacyVC
            self.window?.rootViewController = slideMenuController
            
        case .about_us:
            
            let aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            let nvc: UINavigationController = UINavigationController(rootViewController: aboutVC)
            leftMenuVC.aboutUsVC = nvc
            nvc.navigationBar.titleTextAttributes = attributes
            let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftMenuVC)
            slideMenuController.automaticallyAdjustsScrollViewInsets = true
            slideMenuController.delegate = aboutVC
            self.window?.rootViewController = slideMenuController
        }
        
       //UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        UINavigationBar.appearance().tintColor = UIColor.black
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
     //   NetworkManager.shared.startMonitoring()
        FirebaseApp.configure()
        self.createMenuView(menu: .home)
        IQKeyboardManager.sharedManager().enable = true
        addShortcuts(application: application)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        NetworkManager.shared.stopMonitoring()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        NetworkManager.shared.stopMonitoring()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
         NetworkManager.shared.startMonitoring()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "RCA")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - App Shortcuts
    func addShortcuts(application: UIApplication) {
        let shortcut1 = UIMutableApplicationShortcutItem(type: "privacy", localizedTitle: "Privacy", localizedSubtitle: nil, icon: nil, userInfo: nil)
        
        let shortcut2 = UIMutableApplicationShortcutItem(type: "aboutus", localizedTitle: "About Us", localizedSubtitle: nil, icon: nil, userInfo: nil)
        
        application.shortcutItems = [shortcut1, shortcut2]
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        let handledShortcutItem = handleShortcutItem(shortcutItem: shortcutItem)
        
        completionHandler(handledShortcutItem)
    }

    func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        var handle:Bool = false
        
        guard let shortcutType = shortcutItem.type as String?  else {
            return false
        }
        
        switch shortcutType {
        case "privacy":
           createMenuView(menu: .privacy_policy)
           handle = true
        case "aboutus":
           createMenuView(menu: .about_us)
            handle = true
        default:
            break
        }

        return handle
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
