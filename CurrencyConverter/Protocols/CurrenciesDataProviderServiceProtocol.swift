//
//  CurrenciesDataProviderServiceProtocol.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation

protocol  CurrenciesDataProviderService: CurrenciesDataProvider {
    
    var dataProvider: CurrenciesDataProvider { get set }
    
}
