//
//  Utils.swift
//  BitcoinTV
//
//  Created by Laptop on 7/18/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import Foundation

typealias Datamap = [String: Any]
typealias Listmap = [Datamap]

extension String {
    var trim: String { return self.trimmingCharacters(in: .whitespacesAndNewlines) }
    
    func pad(_ n: Int, _ text: String = " ") -> String {
        let ini = 0
        return self.padding(toLength: n, withPad: text, startingAt: ini)
    }
    
    func parse() -> Datamap {
        var dixy = Datamap()
        
        do {
            let data = self.data(using: .utf8)!
            dixy = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Datamap
        } catch {
            print("JSON.error: ", error)
        }
        
        return dixy
    }
    
    func parseList() -> Listmap {
        var list = Listmap()
        
        do {
            let data = self.data(using: .utf8)!
            list = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Listmap
        } catch {
            print("JSON.error: ", error)
        }
        
        return list
    }
    
}

extension Int {
    func toThousands() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(for: self) ?? "0"
    }
    
    var money: String { return "$"+self.toThousands() }
}

extension Double {
    func format(_ num: Int, _ dec: Int = 2) -> String {
        let fmt = "\(num).\(dec)"
        return String(format: "%\(fmt)f", self)
    }
    
    var money: String { return "$"+format(10,2).trim }
    var moneyInt: String { return Int(self).money }
    var percent: String { return self.format(10,2).trim + "%" }
}

extension Date {
    static func epoch(_ time: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(time))
    }
    
    // APR 25, 8:35 AM
    func short() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm a"
        let text = formatter.string(from: self).uppercased()
        return text
    }
}

extension Optional {
    var string: String {
        get {
            return self as? String ?? ""
        }
    }
    
    var int: Int {
        get {
            return Int(self as? String ?? "0") ?? 0
        }
    }
    
    var double: Double {
        get {
            return Double(self as? String ?? "0.0") ?? 0.0
        }
    }
}


// END
