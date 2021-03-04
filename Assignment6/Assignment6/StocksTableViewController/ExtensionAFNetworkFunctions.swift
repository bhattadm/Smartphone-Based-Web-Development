//
//  ExtensionAFNetworkFunctions.swift
//  Assignment6
//
//  Created by Megha Bhattad on 3/1/21.
//
import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import RealmSwift
 import PromiseKit

extension StockTableViewController{
    func getUrl() -> String{
         var url = api_url
         url.append(api_key)
         return url
         
     }
     
    func getData(){
        let url = getUrl()
        
        getQuickShortQuote(url)
                    .done { (stocks) in
                        self.stockArr = [Stock]()
                        for stock in stocks {
                            self.stockArr.append(stock)
                        }
                        self.TblStocks.reloadData()
                    }
                    .catch { (error) in
                        print("Error in getting all the stock values \(error)")
                    }
        
        //SwiftSpinner.show("Getting Stock Values")
//        AF.request(url).responseJSON {  response in
//            //SwiftSpinner.hide()
//            if(response.error == nil){
//                guard let data = response.data else {return}
//                guard let stocks = JSON(data).array else {return}
//                if(stocks.count == 0){
//                    return
//                }
//                self.stockArr = [Stock]()
//
//                for stock in stocks {
//                    let symbol  = stock["symbol"].stringValue
//                    let price   = stock["price"].floatValue
//                    let volume  = stock["volume"].intValue
//
//                    let stock = Stock()
//                    stock.symbol = symbol
//                    stock.price = price
//                    stock.volume = volume
//
////                    self.stockArr.append(Stock(symbol: symbol, price: price, volume: volume))
//                    self.stockArr.append(stock)
//                }
//                self.TblStocks.reloadData()
//            }
//        }
    }
    
    @objc func getStockData(){
            getData()
            self.refreshControl?.endRefreshing()
        }
    
    func getQuickShortQuote(_ url : String) -> Promise<[Stock]>{
            
        return Promise<[Stock]> { seal -> Void in
            AF.request(url).responseJSON {  response in
                //SwiftSpinner.hide()
                if(response.error == nil){
                    var arr  = [Stock]()
                    guard let data = response.data else {return seal.fulfill( arr ) }
                    guard let stocks = JSON(data).array else { return  seal.fulfill( arr )}
                    
                    for stock in stocks {
                        let symbol  = stock["name"].stringValue
                        let price   = stock["price"].floatValue
                        let volume  = stock["volume"].intValue
                        
                        let stock = Stock()
                        stock.symbol = symbol
                        stock.price = price
                        stock.volume = volume
 
                        arr.append(stock)
                    }
                    seal.fulfill(arr)
                }
                else {
                    seal.reject(response.error!)
                }
            }//AF req
        }//end of promise
    }//end of function
}// end of class

