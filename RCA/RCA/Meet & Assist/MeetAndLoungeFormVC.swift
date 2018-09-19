//
//  MeetAssistFormVC.swift
//  RCA
//
//  Created by Ashok Gupta on 11/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

enum ProductType: String {
    
   case Transit = "Transit"
    case Departure = "Departure"
   case Arrival = "Arrival"
}

struct FormData {
    var productType: String = ""
    var travelDate: String = ""
    var adultCount: Int = 0
    var childCount: Int = 0
    var childAge:[Int] = []
}

class MeetAndLoungeFormVC: UIViewController {
    
    @IBOutlet weak var segmentProductType: UISegmentedControl!
    @IBOutlet weak var tblForm: UITableView!
    @IBOutlet weak var btnContinue: RoundButton!
    var form:FormData = FormData()
    
    var service:Service_list?
    var popView: PopTipView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.title =  service?.product_id == "2" ?  "Meet & Assist" : "Lounge"
        
        tblForm.registerCellNib(LoungeFormCell.self)
        tblForm.registerCellNib(AgeCell.self)
        tblForm.rowHeight = UITableViewAutomaticDimension
        tblForm.estimatedRowHeight = 160
        
        segmentProductType.selectedSegmentIndex = 0
        form.productType = ProductType.Transit.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentProductTypeValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            form.productType = ProductType.Transit.rawValue
        case 1:
            form.productType = ProductType.Departure.rawValue
        case 2:
            form.productType = ProductType.Arrival.rawValue
        default:
            break
        }
    }
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        
    }
}

extension MeetAndLoungeFormVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else {
            
           return form.childCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoungeFormCell.identifier) as! LoungeFormCell
            cell.delegate = self
            
            cell.setData(form)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AgeCell.identifier) as! AgeCell
            cell.tag = indexPath.row
            cell.delegate = self
            cell.setData(form.childAge[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension MeetAndLoungeFormVC : LoungeFormCellDelegate {
    func updateCount(stepperView: StepperView, count: String) {
        
        if stepperView.tag == 0 {
            form.adultCount = Int(count)!
             tblForm.reloadSections(IndexSet(integer: 0), with: .none)
        }
        else {
            form.childCount = Int(count)!
            
            if stepperView.isIncrementTapped {
                 form.childAge.append(0)
            }
            else {
                form.childAge.removeLast()
            }
           
            tblForm.reloadData()
        }
    }
    
    func btnCalenderTapped(sender: UIButton) {
        let calendar = SACalendar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 300))
        calendar?.delegate = self
        
        popView = PopTipView()
        popView?.initializePop(calendar)
        popView?.showPop(sender, overView: self.view)
    }
    
    func btnCalendarPopOverTapped(sender: UIButton) {

        let calendarVC = Utils.getCalendarStoryboardController(identifier: Constant.CALENDAR_VC) as! CalendarVC
        calendarVC.delegate = self
        view.addSubview(calendarVC.view)
        addChildViewController(calendarVC)
    }
}

extension MeetAndLoungeFormVC : SACalendarDelegate {
    func saCalendar(_ calendar: SACalendar!, didSelectDate day: Int32, month: Int32, year: Int32) {
        
        form.travelDate = String(day) + "-" + String(month) + "-" + String(year)
        tblForm.reloadSections(IndexSet(integer: 0), with: .none)
        popView?.dismiss()
        popView = nil
    }
}

extension MeetAndLoungeFormVC : CalendarVCDelegate {
    func selectedDate(date: String) {
        form.travelDate = date
        tblForm.reloadSections(IndexSet(integer: 0), with: .none)
    }
}

extension MeetAndLoungeFormVC : AgeCellDelegate {
    func updateAge(age: Int, row: Int) {
        
        form.childAge[row] = age
    }
}
