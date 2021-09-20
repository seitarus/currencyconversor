//
//  CurrenciesDataProvider.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation

protocol CurrenciesDataProvider {

    func getTransactionsList(completion: @escaping ([Transaction]) -> Void)
    
    func getRatesList(completion: @escaping ([Rate]) -> Void)
    
}

