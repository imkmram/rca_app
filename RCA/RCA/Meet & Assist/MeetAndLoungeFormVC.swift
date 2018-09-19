//
//  MeetAssistFormVC.swift
//  RCA
//
//  Created by Ashok Gupta on 11/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

struct FormData {
    var travelType: TravelType?
    var travelDate: String = ""
    var adultCount: Int = 0
    var childCount: Int = 0
    var childAge:[Int] = []
}

class MeetAndLoungeFormVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var segmentProductType: UISegmentedControl!
    @IBOutlet weak var tblForm: UITableView!
    @IBOutlet weak var btnContinue: RoundButton!
    
    //MARK: - Variables
    var form:FormData = FormData()
    var service:Service_list?
    var popView: PopTipView?

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.title =  service?.product_id == "2" ?  "Meet & Assist" : "Lounge"
        
        tblForm.registerCellNib(LoungeFormCell.self)
        tblForm.registerCellNib(AgeCell.self)
        tblForm.rowHeight = UITableViewAutomaticDimension
        tblForm.estimatedRowHeight = 160
        
        if service?.product_id == "3" {
            
            segmentProductType.removeSegment(at: 2, animated: true)
        }

        segmentProductType.selectedSegmentIndex = 0
        form.travelType = TravelType.Departure
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Events
    @IBAction func segmentProductTypeValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            form.travelType = TravelType.Departure
        case 1:
            form.travelType = TravelType.Transit
        case 2:
            form.travelType = TravelType.Arrival
        default:
            break
        }
    }
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        
        let listingVC = Utils.getMeet_AssistStoryboardController(identifier: Constant.MEET_LOUNGE_VC) as! MeetAndLoungeListingVC
        listingVC.formData = form
        listingVC.service = service
        self.navigationController?.pushViewController(listingVC, animated: true)
    }
}

//MARK: - UITableView Datasource & Delegate
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

// MARK: - LoungeFormCell Delegate
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

//MARK: - SACalendar Delegate
extension MeetAndLoungeFormVC : SACalendarDelegate {
    func saCalendar(_ calendar: SACalendar!, didSelectDate day: Int32, month: Int32, year: Int32) {
        
        form.travelDate = String(day) + "-" + String(month) + "-" + String(year)
        tblForm.reloadSections(IndexSet(integer: 0), with: .none)
        popView?.dismiss()
        popView = nil
    }
}

//MARK: - CaleandarVC Delegate
extension MeetAndLoungeFormVC : CalendarVCDelegate {
    func selectedDate(date: String) {
        form.travelDate = date
        tblForm.reloadSections(IndexSet(integer: 0), with: .none)
    }
}

//MARK: - AgeCell Delegate
extension MeetAndLoungeFormVC : AgeCellDelegate {
    func updateAge(age: Int, row: Int) {
        
        form.childAge[row] = age
    }
}
