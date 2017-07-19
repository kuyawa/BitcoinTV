//
//  TableController.swift
//  BitcoinTV
//
//  Created by Laptop on 7/18/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import UIKit

class TableController: NSObject, UITableViewDelegate, UITableViewDataSource {

    var ticker  = Ticker()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticker.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        let coin = ticker.coins[indexPath.row]
        
        cell.textSymbol.text = coin.symbol
        cell.textName.text   = coin.name
        cell.textPrice.text  = coin.priceUsd.format(10,4)
        cell.textVolume.text = Int(coin.volumeUsd).toThousands()
        cell.textMarket.text = Int(coin.marketUsd).toThousands()
        
        if coin.change01h < 0 {
            cell.textPrice.textColor = Theme.Color.red
        } else {
            cell.textPrice.textColor = Theme.Color.green
        }
        
        return cell
    }
}

// END
