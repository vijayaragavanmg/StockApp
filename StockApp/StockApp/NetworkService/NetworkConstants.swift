//
//  NetworkConstants.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import Foundation

let errorDomain              = "com.StockApp.ErrorDomain"

struct ErrorDescription {
    static let urlNil        = "URL Nil"
    static let sessionNil    = "Session Nil"
    static let unknownError  = "Unknown Error"
}

enum ServiceErrorType: Int {
    case ServiceErrorURLInvalid = -1989
    case ServiceErrorSessionNil
    case ServiceErrorUnkown
}

