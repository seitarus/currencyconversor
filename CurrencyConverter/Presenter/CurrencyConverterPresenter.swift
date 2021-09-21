//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation
class CurrencyConverterPresenter {
    var view: ProductsViewObservable?
  
    var transactionsList = [Transaction](){
        didSet {
            
            if transactionsList.count > 0 {
                var temp = [String]();
                transactionsList.forEach({ transaction in
                    temp.append(transaction.sku)
                })
                
                self.productsList = Array(Set(temp)).map({ sku in
                    return Product(sku: sku)
                })
            }
            
            view?.updateUI()
        }
    }
    
    var ratesList = [Rate]()
        
    var productsList = [Product]()
}

extension CurrencyConverterPresenter: ProductsViewObserver {
    
    func getProductsList() -> [Product] {
        return productsList
    }
    
    func getProductTransactions(product: Product, toCurrency: Currency) -> [Transaction] {
        
        var productTransactions = [Transaction]()
        
        var total = 0.0
        
        let conversor = Conversor( rates: self.ratesList )
                                  
        transactionsList.forEach { transaction in
            
            if transaction.sku == product.sku {
                
                productTransactions.append(transaction)
                                
                let rate = conversor.convert( from: Currency(name:transaction.currency), to: toCurrency)
                
                var convertedAmount = 0.0
                
                if let amount = Double(transaction.amount) {
                    convertedAmount = rate * amount
                }
                
                total += convertedAmount
            }
        }
        
        let transaction = Transaction(sku: product.sku, amount: String(format: "%f", total), currency: toCurrency.name)
     
        productTransactions.append( transaction )
            
        return productTransactions
            
    }
}
