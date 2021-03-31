//
//  TableViewCell.swift
//  CovidData
//
//  Created by Megha Bhattad on 3/30/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCases: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
