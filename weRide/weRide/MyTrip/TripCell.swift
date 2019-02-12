//
//  TripCell.swift
//  weRide
//
//  Created by Ashok Gupta on 24/09/18.
//  Copyright © 2018 Ashok Gupta. All rights reserved.
//

import UIKit

protocol TripCellDelegate: class {
//    func btnStartTapped(sender: RoundButton)
//    func btnViewTapped(sender: RoundButton)
//    func btnEndTapped(sender: RoundButton)
}

class TripCell: BaseTableViewCell {
    
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
  //  weak var delegate: TripCellDelegate?
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.layer.cornerRadius = 10.0
    }
    
    override func setData(_ data: Any?) {
        
        if let rideData = data as? Result_set {
            
            lblTitle.text = rideData.ride_name
            lblOwner.text = rideData.owner_name
            
            guard let strURL = rideData.ride_image?.replacingOccurrences(of: "../", with:  Constant.kBASE_URL) else {
                return
            }
            
            if let url: URL = URL(string: strURL) {
                imgTrip.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "thumbnail"), options: .cacheMemoryOnly, completed: nil)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    @IBAction func btnStartTapped(_ sender: RoundButton) {
//        delegate?.btnStartTapped(sender: sender)
//    }
//
//    @IBAction func btnViewTapped(_ sender: RoundButton) {
//         delegate?.btnViewTapped(sender: sender)
//    }
//
//    @IBAction func btnEditTapped(_ sender: RoundButton) {
//         delegate?.btnEndTapped(sender: sender)
//    }
}
