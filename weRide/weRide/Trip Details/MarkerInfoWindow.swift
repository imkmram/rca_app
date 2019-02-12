//
//  MarkerInfoWindow.swift
//  weRide
//
//  Created by Ashok Gupta on 25/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

class MarkerInfoWindow: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    func setData(place:String) {
        
        lblTitle.text = place
    }
    
    @IBAction func btnEditTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var btnDeleteTapped: UIButton!
}
