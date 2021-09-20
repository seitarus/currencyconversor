//
//  TransactionDetailTableViewController.swift
//  CurrencyConverter
//
//  Created by Alex on 18.09.21.
//  Copyright © 2021 Alex. All rights reserved.
//

import UIKit

class TransactionDetailTableViewController: UITableViewController {
    
    var transactions = [Transaction]()
    
    var presenter: ProductsViewObserver?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return DefaultKeys.DEFAULT_COUNT_OF_SECTION
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count - 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        
        let transaction = transactions[indexPath.row]
        
        cell.textLabel?.text = "\(transaction.amount) \(transaction.currency)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.tableView.frame.width,
                                              height: 50))
        footerView.backgroundColor = .orange
        
        let transaction = transactions[transactions.count-1]
        
        let totalTransaction =  UILabel(frame: footerView.bounds)
        totalTransaction.textAlignment = .right
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .halfUp
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let formattedAmount = Double(transaction.amount) ?? 0.0
        
        totalTransaction.text = "TOTAL: \(formatter.string(from: NSNumber(value: formattedAmount)) ?? "") \(transaction.currency)"
        
        footerView.addSubview( totalTransaction )
        
        return footerView
    }
    
}
