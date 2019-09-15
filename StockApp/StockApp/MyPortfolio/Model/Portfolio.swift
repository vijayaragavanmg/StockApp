//
//  Portfolio.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import Foundation

class Portfolio: Codable {
    
    var date: String?
    var adjClose: Double?
    var high: Double?
    var low: Double?
    var open: Double?
    var close: Double?
    var volume: Double?
    var predictedValue: Double?
    
    private enum CodingKeys: String, CodingKey {
        case date = "Company"
        case adjClose = "Adj Close"
        case high = "High"
        case low = "Low"
        case open = "Open"
        case close = "Close"
        case volume = "Volume"
        case predictedValue = "Scored Labels"
    }
    
}
