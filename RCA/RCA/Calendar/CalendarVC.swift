//
//  CalendarVC.swift
//  RCA
//
//  Created by Ashok Gupta on 12/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

protocol CalendarVCDelegate: class {
    func selectedDate(date:String)
}

class CalendarVC: UIViewController {
    
    @IBOutlet weak var calendarBaseView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    weak var delegate: CalendarVCDelegate?
    var selectedDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let calendar = SACalendar(frame: CGRect(x: 0, y: 0, width: calendarBaseView.bounds.width, height: calendarBaseView.bounds.height))
        calendar?.delegate = self
        calendarBaseView.addSubview(calendar!)
        
        showViewWithAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
    
        hideViewWithAnimation()
        delegate?.selectedDate(date: selectedDate ?? "")
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        hideViewWithAnimation()
    }
    
    //MARK: - Animation Method
    private func showViewWithAnimation() {
        
        self.view.alpha = 0
        contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1
        }
    }
    
    private func hideViewWithAnimation() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
           self.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.view.alpha = 0
            
        }, completion: {
            (value: Bool) in
            
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
        })
    }
}

extension CalendarVC : SACalendarDelegate {
    
    func saCalendar(_ calendar: SACalendar!, didSelectDate day: Int32, month: Int32, year: Int32) {
        
        selectedDate = String(day) + "-" + String(month) + "-" + String(year)
    }
}
