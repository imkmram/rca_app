//
//  DocumentVC.swift
//  FaceVision
//
//  Created by Ashok Gupta on 22/01/19.
//  Copyright © 2019 IntelligentBee. All rights reserved.
//

import UIKit

protocol DocumentVCDelegate: class {
    func selectedDocument(document: Document)
}

class DocumentVC: UIViewController {

    @IBOutlet weak var tblDocument: UITableView!
    
    weak var delegate: DocumentVCDelegate!
    
    var selectedCountry:Country!
    var selectedDoc:Document!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DocumentVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCountry.document?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if let document = selectedCountry.document?[indexPath.row] {
            
            cell.textLabel?.text = document.doc_name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedDoc = selectedCountry.document?[indexPath.row]
        self.delegate.selectedDocument(document: selectedDoc)
        self.navigationController?.popViewController(animated: true)
    }
}
