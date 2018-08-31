//
//  E_VisaVC.swift
//  RCA
//
//  Created by TWC on 02/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit

struct E_Visa {
    var countryCode:Int?
    var title:String?
    var description:String?
    var image:UIImage?
    var origin:String?
    var destination:String?
}

class E_VisaVC: UIViewController {

    @IBOutlet weak var tblEVisa: UITableView!
    
      var e_visaList :[E_Visa] = [E_Visa]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblEVisa.registerCellNib(HomeCell.self)
        tblEVisa.rowHeight = UITableViewAutomaticDimension
        tblEVisa.estimatedRowHeight = 160
        
        e_visaList.append(E_Visa(countryCode:1, title: "Malaysia", description: "eVisa service", image: #imageLiteral(resourceName: "malaysia"), origin:"India", destination:"Malaysia"))
        e_visaList.append(E_Visa(countryCode:2, title: "Hong Kong", description: "Coming Soon", image:#imageLiteral(resourceName: "hongkong"), origin:"India", destination:"Hong Kong"))
        e_visaList.append(E_Visa(countryCode:3, title: "Sri Lanka", description: "Coming Soon", image: #imageLiteral(resourceName: "srilanka"), origin:"India", destination:"Sri Lanka"))
        e_visaList.append(E_Visa(countryCode:4, title: "Others", description: "Coming Soon", image: #imageLiteral(resourceName: "other_countries"), origin:"India", destination:""))
    }

    override func viewWillAppear(_ animated: Bool) {
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension E_VisaVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return e_visaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier) as! HomeCell
        let data : E_Visa = e_visaList[indexPath.row]
        cell.setData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
            let eVisaVC = storyboard.instantiateViewController(withIdentifier: "E_VisaDetailVC") as! E_VisaDetailVC
            
            eVisaVC.country = e_visaList[indexPath.row]
            setBackTitle(title: "\(String(describing: eVisaVC.country.title ?? "")) eVisa")
            
            self.navigationController?.pushViewController(eVisaVC, animated: true)
        }
    }
}
