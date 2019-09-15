//
//  MyPortfolioTableViewCellViewModel.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import Foundation


class MyPortfolioTableViewCellViewModel : NSObject {
    
    weak var portfolio:Portfolio?
    var portfolioTableViewCell:MyPortfolioTableViewCellProtocol?
    
    init?(model:Portfolio?) {
        
        guard let model = model else {
            return nil
        }
        super.init()
        self.portfolio = model
    }
    
    func setView(_ view:MyPortfolioTableViewCellProtocol) {
        self.portfolioTableViewCell = view
    }
    
    func setup() {
        guard let portfolioTableViewCell = portfolioTableViewCell ,
            let portfolio = portfolio else {
                return
        }
        portfolioTableViewCell.setPortfolioDetails(portfolioModel: portfolio)
    }
    
}

