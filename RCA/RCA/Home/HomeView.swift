//
//  HomeView.swift
//  RCA
//
//  Created by TWC on 26/07/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import Foundation


protocol HomeView:BaseView {
    
    func setData<T>(data:[T])
    func emptyList()
}
