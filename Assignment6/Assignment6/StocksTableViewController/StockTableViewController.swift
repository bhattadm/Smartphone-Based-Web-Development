//
//  StockTableViewController.swift
//  Assignment6
//
//  Created by Megha Bhattad on 2/28/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import RealmSwift

class StockTableViewController: UITableViewController {
    
    @IBOutlet var TblStocks: UITableView!
    var symbolArr: [String] = [String]()
    var stockArr: [Stock] = [Stock]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getStockData), for: .valueChanged)
        self.refreshControl = refreshControl
        
        
//        do{
//           let _ = try Realm()
//        }catch{
//            print("Error in initializing Realm")
//        }
//        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    override func viewWillAppear(_ animated: Bool) {
//       self.addStockToDB()
        getData()
    }

}
