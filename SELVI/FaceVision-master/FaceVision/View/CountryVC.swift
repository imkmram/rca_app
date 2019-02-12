//
//  CountryVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 22/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol CountryVCDelegate: class {
    func selectedCountry(country: Country)
}

class CountryVC: UIViewController {
    
    @IBOutlet weak var tblCountry: UITableView!
    
    weak var delegate: CountryVCDelegate!
    var countryList:[Country] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCountries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
         navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.sizeToFit()
        
        if #available(iOS 11.0, *) {
            
            self.navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            navigationItem.titleView = searchController.searchBar
            navigationItem.titleView?.layoutSubviews()
        }
        
        if UserDefaults.standard.object(forKey: UserDefaultsKeys.lastAPICall.rawValue) != nil {
            
            let currentDate = Date.getCurrentDate()
            
            if UserDefaults.standard.getLastAPICall() != currentDate {
                getDataFromAPI()
            }
            else {
                getDataLocally()
            }
        }
        else {
            getDataFromAPI()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
  private func getDocumentDirectory() -> URL {

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
//    private func isFileAvaialble() -> Bool {
//
//        let dirURL = getDocumentDirectory()
//        let fileURL = dirURL.appendingPathComponent("data.txt")
//        if FileManager.default.fileExists(atPath: fileURL.path) {
//            return true
//        }
//        return false
//    }
    
    private func writeToFile(fileContent: String) {

        let fileName = getDocumentDirectory().appendingPathComponent("data.json")
            do {
                 try fileContent.write(to: fileName, atomically: true, encoding: .utf8)
                UserDefaults.standard.set(Date.getCurrentDate(), forKey: UserDefaultsKeys.lastAPICall.rawValue)
                getDataLocally()
            }
            catch {
            }
    }
    
   private func getDataFromAPI() {
        
        SVProgressHUD.show()

                if let url = URL(string: Constant.kBaseURL + "?method=getCountryDoc") {

                    fetchCountries(url: url, method: "GET") { (response) in

                        DispatchQueue.main.async {
                            
                            SVProgressHUD.dismiss()
                            switch response {
                            case .success(let baseModel):
                                
                                self.parseData(model: baseModel)
                                print("Success")

                            case .failure(let error):
                                self.showAlertWith(title: "Error", message: error.localizedDescription)
                                print("Failure")
                            }
                        }
                    }
                }
    }
    
   private func parseData(model: BaseModel) {
        print(model)
//        if let list = model.result?.country {
//            countryList = list
//        }
 
        // For local directory
        if let encodedData = try? JSONEncoder().encode(model) {
            print(String(data: encodedData, encoding: .utf8))

            if let content = String(data: encodedData, encoding: .utf8) {
                writeToFile(fileContent: content)
            }
        }
    }
    
    func getDataLocally() {
        
        let url = getDocumentDirectory().appendingPathComponent("data.json")
        
        do {
            let fileData = try Data(contentsOf: url)
            do {
                let responseData = try JSONDecoder().decode(BaseModel.self, from: fileData) as BaseModel
                countryList = responseData.result?.country ?? []
                tblCountry.reloadData()
            }
            catch {
            }
        }
        catch {
            return
        }
    }

    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCountries = countryList.filter({( country : Country) -> Bool in
            return (country.name?.lowercased().contains(searchText.lowercased()))!
        })
        
        tblCountry.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    extension CountryVC : UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if isFiltering() {
                return filteredCountries.count
            }
            else {
                return countryList.count
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 55
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            let country: Country
            if isFiltering() {
                country = filteredCountries[indexPath.row]
            }
            else {
                country = countryList[indexPath.row]
            }
            cell.textLabel?.text = country.name
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let country: Country
            
            if isFiltering() {
                country = filteredCountries[indexPath.row]
            }
            else {
                country = countryList[indexPath.row]
            }
            
            self.delegate.selectedCountry(country: country)
            
            self.navigationController?.popViewController(animated: true)
        }
    }

extension CountryVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
       filterContentForSearchText(searchController.searchBar.text!)
    }
}
