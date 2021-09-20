//
//  CurrencySelectorTableViewController.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    var productsList = [Product]()
    var presenter: ProductsViewObserver?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return DefaultKeys.DEFAULT_COUNT_OF_SECTION
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        cell.textLabel?.text = productsList[indexPath.row].sku
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = productsList[indexPath.row]
        
        self.performSegue(withIdentifier: "showDetail", sender: product)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            
            let transactionDetailTableViewController = segue.destination as! TransactionDetailTableViewController
            
            let eur = Currency(name: "EUR")
            
            if let product = sender as? Product {
             
                let transactions = presenter?.getProductTransactions( product: product, toCurrency: eur )
                if transactions != nil, transactions!.count > 0 {
                    
                    transactionDetailTableViewController.transactions = transactions!
                    
                }
            }
        }
    }
}

extension ProductsTableViewController {
    private func setupPresenter() {
        presenter = ServiceLocator.resolve(presenterType: .CurrencyConverterViewPresenter) as? ProductsViewObserver
        presenter?.view = self
        
        updateUI()
    }
}

extension ProductsTableViewController: ProductsViewObservable {
    
    func updateUI() {
        
        let productsList = presenter?.getProductsList()
        if productsList != nil, productsList!.count > 0 {
        
            self.productsList = productsList!
        }
            
        self.tableView.reloadData()
        
    }
}

struct DefaultKeys {
    static let DEFAULT_COUNT_OF_SECTION: Int = 1
}
