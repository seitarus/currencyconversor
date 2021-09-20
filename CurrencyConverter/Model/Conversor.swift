//
//  Conversor.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation

class Conversor {
    
    let rates: [Rate]
    
    var visited = [[String: Bool]]()
    
     init (rates: [Rate] ) {
        self.rates = rates
    }
    
    func convert(from: Currency, to: Currency) -> Double {
        
        var ratesGraph = [String: [Node]]()
        
        self.rates.forEach { rate in
            
            let cost = Double(rate.rate) ?? 0.0
            
            if ratesGraph[rate.from] == nil {
                ratesGraph[rate.from] = [Node(currency: rate.to, rate: cost) ]
            }
            
            if ratesGraph[rate.to] == nil {
                ratesGraph[rate.to] = [Node(currency: rate.from, rate:  Double(1) / cost)]
            }
        }

        var queue = [Node]()
        queue.append( Node(currency: from.name, rate: 1.0) )
        
        var visited = [String]()
        
        while (queue.count > 0) {
            
            let firstElement = queue.removeFirst()
            let curr = firstElement.currency
            let num = firstElement.rate
            
            if visited.contains( curr ) {
                continue
            }
            
            visited.append( curr )
            
            if (ratesGraph.index(forKey: curr) != nil) {
                
                let values = ratesGraph[curr]
                
                var next = [String: Double]()
                
                values?.forEach({ node in
                    next[ node.currency ] = node.rate
                })
                
                for key in next.keys {
                    
                    if !visited.contains(key) {
                        
                        if key == to.name {
                            
                            if let a = next[key] {
                                
                                return Double(num * a)
                                
                            }
                        }
                        
                        if let _ = next[key] {
                            queue.append( Node (currency: key, rate: num * next[key]!))
                        }
                    }
                }
            }
        }
        
        return 1.0
    }
    
    struct Node {
        var currency : String
        var rate : Double
        
    }
}


