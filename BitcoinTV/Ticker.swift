//
//  Ticker.swift
//  BitcoinTV
//
//  Created by Laptop on 7/18/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import Foundation

class Ticker {
    var coins   = [Coin]()
    var count: Int { get { return coins.count } }
    var updated = Date()
    
    convenience init(json: String) {
        self.init()
        let list = json.parseList()
        var data = [Coin]()
        
        for item in list {
            let coin = Coin()
            coin.id          = item["id"].string
            coin.name        = item["name"].string
            coin.symbol      = item["symbol"].string
            coin.rank        = item["rank"].int
            coin.priceUsd    = item["price_usd"].double
            coin.priceBtc    = item["price_btc"].double
            coin.volumeUsd   = Double((item["24h_volume_usd"]     as? String) ?? "0.0") ?? 0.0
            coin.marketUsd   = Double((item["market_cap_usd"]     as? String) ?? "0.0") ?? 0.0
            coin.available   = Double((item["available_supply"]   as? String) ?? "0.0") ?? 0.0
            coin.totalSupply = Double((item["total_supply"]       as? String) ?? "0.0") ?? 0.0
            coin.change01h   = Double((item["percent_change_1h"]  as? String) ?? "0.0") ?? 0.0
            coin.change24h   = Double((item["percent_change_24h"] as? String) ?? "0.0") ?? 0.0
            coin.change07d   = Double((item["percent_change_7d"]  as? String) ?? "0.0") ?? 0.0
            coin.trend       = (coin.change01h == 0 ? 0 : (coin.change01h > 0 ? 1 : 2))
            coin.updated     = Int((item["last_updated"] as? String) ?? "0") ?? 0
            //coins.append(coin)
            data.append(coin)
        }
        
        // First ten coins
        for index in 0 ..< 10 {
            coins.append(data[index])
        }
        
        // Then sorted by symbol
        let sorted = data.sorted { $0.symbol < $1.symbol }
        for coin in sorted {
            coins.append(coin)
        }
    }
    
    func show() {
        for coin in coins {
            print(coin.text)
        }
    }
    
}

class Coin {
    var id          = "bitcoin"
    var name        = "Loading..."
    var symbol      = "ALL"
    var rank        = 0
    var priceUsd    = 0.0
    var priceBtc    = 0.0
    var volumeUsd   = 0.0
    var marketUsd   = 0.0
    var available   = 0.0
    var totalSupply = 0.0
    var change01h   = 0.0
    var change24h   = 0.0
    var change07d   = 0.0
    var trend       = 0    // 0:same 1:up 2: down
    var updated     = 0
    
    var text: String { get { return "\(symbol.pad(5)) \(name.pad(25)) \(priceUsd.format(12,4))" } }
    
}

// END
