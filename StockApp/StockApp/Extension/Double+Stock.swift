//
//  Double+Stock.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import Foundation

extension Double
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        var timeInterval: TimeInterval = self
        timeInterval = timeInterval/1000
        let date = Date(timeIntervalSince1970: timeInterval)
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
}
