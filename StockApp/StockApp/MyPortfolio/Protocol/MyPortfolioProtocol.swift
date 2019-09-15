//
//  MyPortfolioProtocol.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import Foundation

protocol MyPortfolioProtocol : class {
    func performInitialTableViewSetup()
    func showLoading()
    func hideLoading()
    func showErrorMessage(errorMessage:String)
    func reloadTable()
    func hideTableView(isHidden:Bool)
}
