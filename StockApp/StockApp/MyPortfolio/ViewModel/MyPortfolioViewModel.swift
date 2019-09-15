//
//  MyPortfolioViewModel.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import UIKit

class MyPortfolioViewModel : NSObject {
    
    
    var portfolios:[Portfolio]?
    
    weak var view:MyPortfolioProtocol?
    
    init(view:MyPortfolioProtocol) {
        super.init()
        self.view = view
    }
    
    func performInitialViewSetup() {
        view?.performInitialTableViewSetup()
    }
    
    func getPortfolios() {
        view?.showLoading()

        let myPortfolioServiceHelper = MyPortfolioHelper()
        
        myPortfolioServiceHelper.getPortfolioList() { (error, portfolios, status) in
            DispatchQueue.main.async {
                self.view?.hideLoading()
                if let portfolios = portfolios {
                    self.view?.hideTableView(isHidden: false)
                    self.portfolios = portfolios
                    self.view?.reloadTable()
                }else if let error = error {
                    self.view?.hideTableView(isHidden: true)
                    self.view?.showErrorMessage(errorMessage: error.localizedDescription)
                }
                
            }
        }
    }
    
//    func getPortfolios() -> [Double]? {
//        return self.portfolios?.flatMap{$0.close} ?? nil
//    }
}

//Extension for tableview delegate
extension MyPortfolioViewModel {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        if let count = portfolios?.count {
            return count
        }
        return 0
    }
    
    func cellViewModel(indexPath:IndexPath) -> MyPortfolioTableViewCellViewModel? {
        guard let currencyRate = portfolios else {
            return nil
        }
        
        if ((indexPath.section < 0) || (indexPath.section >= currencyRate.count)) {
            return nil
        }
        
        if ((indexPath.row < 0) || (indexPath.row >= numberOfRowsInSection(indexPath.row))) {
            return nil
        }
        
        return MyPortfolioTableViewCellViewModel(model: portfolios?[indexPath.row])
    }
    
    func tableCellBackgroundColor(indexPath:IndexPath) -> UIColor {
        
        return indexPath.row % 2 == 0 ? UIColor(red: 18.0/255.0, green: 16.0/255.0, blue: 18.0/255.0, alpha: 1.0) : UIColor(red: 23.0/255.0, green: 23.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        
    }
    
    func tableHeaderSectionHeight() -> CGFloat {
        return 50
    }
    
    func tableCellHeight() -> CGFloat {
        return 50
    }
    
}
