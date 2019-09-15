//
//  MyPortfolioTableViewCell.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import UIKit

class MyPortfolioTableViewCell: UITableViewCell {

    @IBOutlet weak var portfolioNameLabel: UILabel!
    @IBOutlet weak var lastPriceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!

    
    var viewModel:MyPortfolioTableViewCellViewModel?
    
    func setup() {
        viewModel?.setup()
    }
    
}

extension MyPortfolioTableViewCell:MyPortfolioTableViewCellProtocol {
    
     func setPortfolioDetails(portfolioModel:Portfolio) {
        portfolioNameLabel.text = portfolioModel.date
        lastPriceLabel.text = String(format: "%.2f", portfolioModel.close ?? 0.0)
        changeLabel.text = String(format: "%.2f", portfolioModel.predictedValue ?? 0.0)
    }
    
}

