//
//  Rate.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation

class Rate: Codable {
    
    let from: String
    let to: String
    let rate: String
        
    init (from: String, to: String, rate: String) {
        self.from = from
        self.to = to
        self.rate = rate
    }
    
}
