//
//  CalendarVC.swift
//  weRide
//
//  Created by Ashok Gupta on 29/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit
protocol DatePickerVCDelegate: class {
    func updateDateTime(date:String, time: String, dateTime: String, tag:Int)
}

class DatePickerVC: UIViewController {
    
    weak var delegate: DatePickerVCDelegate?
    @IBOutlet weak var datePicker: UIDatePicker!
    var strDate: String = ""
    var strTime: String = ""
    var strDateTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(didValueChanged(sender:)), for: .valueChanged)
    }

    @IBAction func btnCancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnDoneTapped(_ sender: UIBarButtonItem) {
        delegate?.updateDateTime(date: strDate, time: strTime, dateTime: strDateTime, tag: self.view.tag)
        self.dismiss(animated: true, completion: nil)
    }
    
   @objc func didValueChanged(sender: UIDatePicker) {
    
        dateToString(date: sender.date)
    }
    
    func dateToString(date: Date) {
        
        let result = Utils.dateToString(date: date)
        print(result)
        
        strDate = result.strDate
        strTime = result.strTime
        strDateTime = result.strDateTime
        
//        let format = "yyyy-MM-dd"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//
//        strDate = dateFormatter.string(from: date)
//
//        let timeFormat = "HH:mm a"
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = timeFormat
//
//        strTime = timeFormatter.string(from: date)
//
//        let displayFormat = "dd-MMM-yyyy h:mm a"
//        let displayFormatter = DateFormatter()
//        displayFormatter.dateFormat = displayFormat
//
//        strDateTime = displayFormatter.string(from: date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
