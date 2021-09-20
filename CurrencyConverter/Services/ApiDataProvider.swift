//
//  FixerIOCAPI.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation
import Alamofire

struct ApiDataProvider: CurrenciesDataProvider {
    
    func getTransactionsList(completion: @escaping ([Transaction]) -> Void) {
        let url = ApiURLMaker.getURLForTransactions()
        CurrencyHTTPTransport.getJson(from: url) { json in
            let transactionsList = CurrencyJsonParser.JsonToTransactionsList(json: json)
            completion(transactionsList)
        }
    }
    
    func getRatesList(completion: @escaping ([Rate]) -> Void) {
        let url = ApiURLMaker.getURLForRates()
        CurrencyHTTPTransport.getJson(from: url) { json in
            let ratesList = CurrencyJsonParser.JsonToRatesList(json: json)
            completion(ratesList)
        }
    }
}

struct ApiURLMaker {
    
    static func getURLForTransactions() -> URL? {
        let url = URL(string: Keys.rootPath + Keys.transactionsPath)
        return url
    }
    
    static func getURLForRates() -> URL? {
        let url = URL(string: Keys.rootPath + Keys.ratesPath)
        return url
    }
    
}

struct CurrencyJsonParser {
    
    static func JsonToTransactionsList(json: Data) -> [Transaction] {
        
        var transactions = [Transaction]()
                
        do {
            transactions = try JSONDecoder().decode([Transaction].self, from: json )
        }catch {
            print("Could not get API data. \(error), \(error.localizedDescription)")
        }
                
        return transactions
    }
    
    static func JsonToRatesList(json: Data) -> [Rate] {
        
        var rates = [Rate]()
                
        do {
            rates = try JSONDecoder().decode([Rate].self, from: json )
        }catch {
            print("Could not get API data. \(error), \(error.localizedDescription)")
        }
        
        return rates
    }
}

struct CurrencyHTTPTransport {
    static func getJson(from url: URL?, completion: @escaping (Data) -> Void) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]

        Alamofire.request(url!, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success( _ ):

                guard let json = response.data else {
                    print("No transactions")
                    return
                }
                
                completion(json)

                break
            case .failure(let error):

                print(error)
            }
        }
    }
}

struct Keys {
    static let rootPath = "http://quiet-stone-2094.herokuapp.com/"
    static let transactionsPath = "transactions"    
    static let ratesPath = "rates"
}
