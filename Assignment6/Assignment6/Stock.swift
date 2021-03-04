//
//  Stock.swift
//  Assignment6
//
//  Created by Megha Bhattad on 2/28/21.
//

import Foundation
import RealmSwift

class Stock:Object{
    @objc dynamic var symbol : String = ""
    @objc dynamic var price  : Float = 0.0
    @objc dynamic var volume : Int = 0
    
    override static func primaryKey() -> String? {
        return "symbol"
    }
    
//    init(symbol:String,price:Float,volume:Int){
//        self.symbol = symbol
//        self.price = price
//        self.volume = volume
//    }
    
}
