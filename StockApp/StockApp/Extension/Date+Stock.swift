//
//  Date+Stock.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import Foundation

extension Date {
    
    func asString(fromFormat:String, toFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        let dateString = formatter.string(from: self)
        let date: Date? = formatter.date(from: dateString)
        formatter.dateFormat = toFormat
        return formatter.string(from: date!)
    }
}
