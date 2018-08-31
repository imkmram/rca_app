//
//  SliderView.swift
//  RCA
//
//  Created by Ashok Gupta on 16/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

class SliderView: UIView, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var pageControllerVC:PageViewController?
    private var selectedIndex :Int = 0
    private var pageIndex = 0
    
   let questionList = [QuestionData(question: "Hey friend, how do I address you as?"),
    QuestionData(question: "So,what is your last name?"),
    QuestionData(question: "I am happy you are flying high. What is your passport number?"),
    QuestionData(question: "I don’t mean to intrude, but how many of you’ll are travelling?."),
    QuestionData(question: "Are you going for Business or as a tourist or transiting?."),
    QuestionData(question: "That sounds interesting. When do you arrive in Malaysia?."),
    QuestionData(question: "How many days are you planning to stay?"),
    QuestionData(question: "That’s great! Let’s get connected. What is your email id?"),
    QuestionData(question: "Thanks. Where can i contact you? Your phone number please…")
    ]
    
    func initializeView() {
        
        let storyboard = UIStoryboard.init(name: Constant.STORYBOARD_E_Visa, bundle: nil)
        
        pageControllerVC = storyboard.instantiateViewController(withIdentifier:Constant.PAGEVIEWCONTROLLER) as? PageViewController
        pageControllerVC?.delegate = self
        pageControllerVC?.dataSource = self
        
        if let startingContentVC : PageViewContentVC = self.viewControllerAtIndex(index: selectedIndex) {
            startingContentVC.delegate = self
            
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
        
        let pageContent :PageViewContentVC = viewController as! PageViewContentVC
        // pageContent.delegate = self
        var index = pageContent.pageIndex
        
        if ((index == 0) || (index >= questionList.count)) {
            return nil;
        }
        
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let pageContent :PageViewContentVC = viewController as! PageViewContentVC
        
       // pageContent.delegate = self
        
        var index = pageContent.pageIndex
        
        if (index == NSNotFound  ) {
            return nil
        }
        
        index += 1;
        if (index == questionList.count) {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        if pendingViewControllers.count > 0 {
            
            if let contentVC = pendingViewControllers[0] as? PageViewContentVC {
               
            }
        }
    }
    
    func viewControllerAtIndex(index:Int) -> PageViewContentVC? {
        
        if ((questionList.count == 0) || (index >= questionList.count)) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        
        let storyboard = UIStoryboard.init(name: Constant.STORYBOARD_E_Visa, bundle: nil)
        
        let contentVC :PageViewContentVC = storyboard.instantiateViewController(withIdentifier: Constant.PAGEVIEWCONTENTVC) as! PageViewContentVC
        
        contentVC.delegate = self
        pageIndex = index
        contentVC.pageIndex = index
        contentVC.loadView()
        
        contentVC.setData(data: questionList[index]);
        
        return contentVC;
    }
}

extension SliderView : PageViewContentVCDelegate {
    
    func goNext() {
        
        if ((questionList.count == 0) || (pageIndex >= questionList.count - 1)) {
            return
        }
        pageIndex += 1
        if let nextContentVC : PageViewContentVC = self.viewControllerAtIndex(index: pageIndex) {
            
            let viewControllers = Array(arrayLiteral: nextContentVC)
            
            pageControllerVC?.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        }
    }
}
