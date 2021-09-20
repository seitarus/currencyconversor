//
//  ServiceLocator.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import Foundation

class ServiceLocator {
    static func resolve(presenterType: PresenterTypeEnum) -> Any? {
        switch presenterType {
        case .CurrencyConverterViewPresenter:
            return createCurrencyConverterViewPresenter()
//        default:
//            return nil
        }
    }
}

extension ServiceLocator {
    private static func createCurrencyConverterViewPresenter() -> ProductsViewObserver? {
        let presenter: CurrencyConverterPresenter? = CurrencyConverterPresenter()
        let apiDataProvider = ApiDataProvider()
        let dataProviderService = CurrencyDataProviderService(dataProvider: apiDataProvider)
        dataProviderService.getTransactionsList() { transactionsList in
            
            presenter?.transactionsList = transactionsList
        }
        
        dataProviderService.getRatesList() { ratesList in
            
            presenter?.ratesList = ratesList
        }
        
        return presenter
    }
}

enum PresenterTypeEnum {
    case CurrencyConverterViewPresenter
}
