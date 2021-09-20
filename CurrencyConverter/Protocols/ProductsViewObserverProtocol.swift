//
//  CurrencyConverterViewObserverProtocol.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation
protocol ProductsViewObserver {

    func getProductsList() -> [Product]
    
    func getProductTransactions(product: Product, toCurrency: Currency) -> [Transaction]
    
    var view: ProductsViewObservable? { get set }
}
