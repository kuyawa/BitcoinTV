//
//  TableViewCell.swift
//  BitcoinTV
//
//  Created by Laptop on 7/18/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var textSymbol : UILabel!
    @IBOutlet weak var textName   : UILabel!
    @IBOutlet weak var textPrice  : UILabel!
    @IBOutlet weak var textVolume : UILabel!
    @IBOutlet weak var textMarket : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
