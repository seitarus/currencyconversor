//
//  CurrencyDataProviderService.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation
struct CurrencyDataProviderService: CurrenciesDataProviderService {
    
    var dataProvider: CurrenciesDataProvider
    
    init (dataProvider: CurrenciesDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func getTransactionsList(completion: @escaping ([Transaction]) -> Void) {
                
        dataProvider.getTransactionsList(completion: completion)
    }
    
    func getRatesList(completion: @escaping ([Rate]) -> Void) {
        
        dataProvider.getRatesList(completion: completion)
    }
}

