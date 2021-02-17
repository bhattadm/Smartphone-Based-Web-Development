//
//  TableViewController.swift
//  TableView Xib
//
//  Created by Megha Bhattad on 2/15/21.
//

import UIKit

class TableViewController: UITableViewController {

    let cities = ["Seattle","Portland","NY","LA","SF","Phoenix"]
    let values = ["43°F","45°F","34°F","65°F","55°F","65°F"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner:self, options:nil)?.first as! TableViewCell

        cell.LblCity.text = cities[indexPath.row]
        cell.LblValue.text = values[indexPath.row]

        return cell
    }
    
}
