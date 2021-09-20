//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation

class Transaction: Codable {
    
    let sku: String
    let amount: String
    let currency: String
    
    init (sku: String, amount: String, currency: String) {
        self.sku = sku
        self.amount = amount
        self.currency = currency
    }
}
