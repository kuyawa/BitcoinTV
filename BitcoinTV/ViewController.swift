//
//  ViewController.swift
//  BitcoinTV
//
//  Created by Laptop on 7/18/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import UIKit

struct Theme {
    struct Color {
        static let red   = UIColor(red: 0.7, green: 0.0, blue: 0.0, alpha: 1.0)
        static let green = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    }
}

class ViewController: UIViewController {

    var ticker  = Ticker()
    var updated = Date()
    var tableController = TableController()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableCell")
        tableView.dataSource = tableController
        tableView.delegate   = tableController
        ticker.coins.append(Coin())  // Dummy coin while loading...
        tableController.ticker = ticker
        tableView.reloadData()
        getTicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getTicker() {
        //print("Loading ticker...")
        let api = "https://api.coinmarketcap.com/v1/ticker/?limit=100"
        let url = URL(string: api)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("Error fetching API")
                print(error ?? "?")
                return
            }
            
            if let text = String(data: data!, encoding: .utf8) {
                //print("Parsing json")
                self.updated = Date()
                self.ticker  = Ticker(json: text)
                //print("----")
                //self.ticker.show()
                //print("----")
                
                DispatchQueue.main.async {
                    self.tableController.ticker = self.ticker
                    self.tableView.reloadData()
                }
            } else {
                print("Error parsing JSON")
                print(error ?? "?")
            }
        }
        task.resume()
    }

}

