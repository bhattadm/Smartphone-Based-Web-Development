//
//  TableViewController.swift
//  Assignment5
//
//  Created by Megha Bhattad on 2/22/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class TableViewController: UITableViewController {

    var titleArr:[News]=[News]()
    
    @IBOutlet var tblNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(titleArr[indexPath.row].title)"
//        return cell
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.lblTitle.text = "\(titleArr[indexPath.row].title)"
               return cell
    }
    
    func getURL()->String{
        var apiurl = url
        apiurl.append(apiKey)
        return apiurl
    }
    
    func getData(){
       let api_url = getURL()
//      SwiftSpinner.show("Getting News Title")
        
        AF.request(api_url).responseJSON { response in
//          SwiftSpinner.hide()
           

            if response.error == nil{

               guard let data = response.data else {return}
               let news = try!JSON(data:data)
//                let news:JSON = JSON(response.data)
                if news["articles"].count == 0{return}
                self.titleArr = [News]()
                
                for newsItem in news["articles"].arrayValue{
                    let author = newsItem["author"].string ?? "No data"
                    let title = newsItem["title"].string ?? "No data"
                    let description = newsItem["description"].string ?? "No data"
                    self.titleArr.append(News( author:author,title:title,description:description ))
                }
                self.tblNews.reloadData()
                
            }
            else{
                print("Error")
            }

        }
    }
    
}

