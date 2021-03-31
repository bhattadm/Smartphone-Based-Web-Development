//
//  TableViewController.swift
//  CovidData
//
//  Created by Megha Bhattad on 3/30/21.
//

import UIKit

import Alamofire
import SwiftyJSON
import SwiftSpinner
import RealmSwift
import PromiseKit

class TableViewController: UITableViewController {

    //@IBOutlet weak var tblView: UITableView!
    //    @IBOutlet weak var tblCovid: UITableViewCell!
    @IBOutlet weak var tblView: UITableView!
    var covidArr: [Data] = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
//       self.addStockToDB()
        getData()
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return covidArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.lblState.text = "\(covidArr[indexPath.row].state)"
        cell.lblCases.text = "$\(covidArr[indexPath.row].cases)"
        cell.lblTotal.text = "$\(covidArr[indexPath.row].total)"
        return cell
    }
    
    
    

func getUrl() -> String{
     var url = api_url
     return url
     
 }

func getData(){
   let url = getUrl()
   
   getQuickShortQuote(url)
               .done { (data) in
                   self.covidArr = [Data]()
                   for item in data {
                       self.covidArr.append(item)
                   }
                   self.tblView.reloadData()
               }
               .catch { (error) in
                   print("Error in getting all the stock values \(error)")
               }
}
func getQuickShortQuote(_ url : String) -> Promise<[Data]>{
    return Promise<[Data]> { seal -> Void in
        AF.request(url).responseJSON {  response in
            print(url);
            if(response.error == nil){
                var arr  = [Data]()
                guard let data = response.data else {return seal.fulfill( arr ) }
                guard let covidData = JSON(data).array else { return  seal.fulfill( arr )}
                
                for data in covidData {
                    let state  = data["state"].stringValue
                    let cases   = data["positive"].intValue
                    let total   = data["total"].intValue
                    print(state);
                    print(cases)
                    let item = Data()
                    item.state = state
                    item.cases = cases
                    item.total = total

                    arr.append(item)
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
