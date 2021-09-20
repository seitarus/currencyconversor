//
//  FixerIOCAPI.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation
import Alamofire

struct MockDataProvider: CurrenciesDataProvider {
    
    func getTransactionsList(completion: @escaping ([Transaction]) -> Void) {
        
        if let path = Bundle.main.path(forResource: "transactions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let transactions = try JSONDecoder().decode([Transaction].self, from: data )
                
                completion(transactions)
                
            } catch {
                // handle error
            }
        }
    }
    
    func getRatesList(completion: @escaping ([Rate]) -> Void) {
        
        if let path = Bundle.main.path(forResource: "rates", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let rates = try JSONDecoder().decode([Rate].self, from: data )
                
                completion(rates)
                
            } catch {
                // handle error
            }
        }
    }
}
