//
//  ImageSliderView.swift
//  RCA
//
//  Created by Ashok Gupta on 21/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class ImageSliderView: UIView, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    private var pageControllerVC:PageViewController?
    private var selectedIndex :Int = 0
    private var pageIndex = 0
    
    var imageList:[UIImage] = []
    
    func initializeView(list: [UIImage]) {
        
        imageList = list
        
//        pageControllerVC = Utils.getE_visaStoryboardController(identifier: Constant.kPAGEVIEWCONTROLLER) as? PageViewController
        
        pageControllerVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
        pageControllerVC?.delegate = self
        pageControllerVC?.dataSource = self
       
        if let startingContentVC : ImagePageViewContentVC = self.viewControllerAtIndex(index: selectedIndex) {
           // startingContentVC.delegate = self
            
            let viewControllers = Array(arrayLiteral: startingContentVC)
            
            pageControllerVC?.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
            
            pageControllerVC?.view.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            
            self.parentViewController?.addChildViewController(pageControllerVC!)
            self.addSubview((pageControllerVC?.view)!)
            pageControllerVC?.didMove(toParentViewController: self.parentViewController)
        }
    }
    
    // MARK:- UIPageViewController Datasource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let pageContent :ImagePageViewContentVC = viewController as! ImagePageViewContentVC
        // pageContent.delegate = self
        var index = pageContent.pageIndex
        
        if ((index == 0) || (index >= imageList.count)) {
            return nil;
        }
        
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let pageContent :ImagePageViewContentVC = viewController as! ImagePageViewContentVC
        
        // pageContent.delegate = self
        
        var index = pageContent.pageIndex
        
        if (index == NSNotFound  ) {
            return nil
        }
        
        index += 1;
        if (index == imageList.count) {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        if pendingViewControllers.count > 0 {
            
            if let contentVC = pendingViewControllers[0] as? ImagePageViewContentVC {
                
            }
        }
    }
    
    func viewControllerAtIndex(index:Int) -> ImagePageViewContentVC? {
        
        if ((imageList.count == 0) || (index >= imageList.count)) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        
        let contentVC = Utils.getMeet_AssistStoryboardController(identifier: Constant.kIMAGEPAGEVIEWCONTENT_VC) as! ImagePageViewContentVC
        
       // contentVC.delegate = self
        pageIndex = index
        contentVC.pageIndex = index
        contentVC.loadView()
        
        contentVC.setData(data: imageList[index]);
        
        return contentVC;
    }
}
