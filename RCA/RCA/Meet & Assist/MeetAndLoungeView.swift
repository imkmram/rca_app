//
//  MeetAndLoungeView.swift
//  RCA
//
//  Created by Ashok Gupta on 19/09/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation

protocol MeetAndLoungeView : BaseView {
    
    //func setList<T>(data:[T])
    func setList(list: [MnA_ProductData])
    func emptyList(error:CustomError, success:Bool)
}
