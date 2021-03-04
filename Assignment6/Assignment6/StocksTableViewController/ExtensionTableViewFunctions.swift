//
//  ExtensionTableViewFunctions.swift
//  Assignment6
//
//  Created by Megha Bhattad on 3/1/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import RealmSwift

extension StockTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stockArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        cell.textLabel?.text = "\(stockArr[indexPath.row].symbol): $\(stockArr[indexPath.row].price)"
        
        let cell = Bundle.main.loadNibNamed("StockTableViewCell", owner: self, options: nil)?.first as! StockTableViewCell
        cell.lblSymbol.text = "\(stockArr[indexPath.row].symbol)"
        cell.lblPrice.text = "$\(stockArr[indexPath.row].price)"
        return cell
    }
    
}

