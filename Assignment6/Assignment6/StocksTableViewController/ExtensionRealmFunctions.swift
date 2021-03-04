//
//  ExtensionRealmFunctions.swift
//  Assignment6
//
//  Created by Megha Bhattad on 3/1/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import RealmSwift
//import PromiseKit

extension StockTableViewController{
    func addStockToDB(){
        do{
            let  realm = try Realm()
            try realm.write{
//                let stock = Stock(symbol: "TSLA",
//                                  price: 127.90,
//                                  volume: 12345)
                let stock = Stock()
                stock.symbol = "AMZN"
                stock.price = 127.90
                stock.volume = 12345
                realm.add(stock)
            }
        }catch{
            print("Error in initializing Realm")
        }
    }
    func doesStockExist(symbol:String)->Bool {
        let realm = try! Realm()
        if realm.object(ofType: Stock.self,forPrimaryKey: symbol) != nil {
            return true
        }
        return false
    }
    
    func addStock(_ symbol:String){}
}
