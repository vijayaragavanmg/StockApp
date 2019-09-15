//
//  MyPortfolioViewController.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import UIKit

class MyPortfolioViewController: UIViewController {

    @IBOutlet weak var portfolioTableView: UITableView!
  
    
    var viewModel:MyPortfolioViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let headerNib = UINib.init(nibName: "MyPortfolioTableHeaderView", bundle: Bundle.main)
        portfolioTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MyPortfolioTableHeaderView")
        
        if self.viewModel == nil {
            self.viewModel = MyPortfolioViewModel(view: self)
        }

        self.viewModel?.performInitialViewSetup()
        
//       let selectedDate = Calendar.current.date(byAdding: .day, value: 10, to: Date())?.asString(fromFormat: "yyyy-MM-dd'T'HH:mm:ss.Z", toFormat: "yyyy-MM-dd'T'HH:mm:ss")
 
        viewModel?.getPortfolios()
    }
    
    func performInitialTableViewSetup()  {
        portfolioTableView.tableFooterView = UIView()
        portfolioTableView.estimatedRowHeight = 200
        portfolioTableView.rowHeight = UITableView.automaticDimension
    }

    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
           if (segue.identifier == "showSummary") {
            let controller = (segue.destination as! UINavigationController).topViewController as! SummaryViewController
              let row = (sender as! NSIndexPath).row; //we know that sender is an NSIndexPath here.
            let portfolio = viewModel?.portfolios?[row]
              controller.selectedPortfolio = portfolio
          }
    }
    
    
}

// Extension for TableView DataSouce Delegates.
extension MyPortfolioViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        
        return viewModel.numberOfRowsInSection(section)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyPortfolioTableHeaderView") as! MyPortfolioTableHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (viewModel?.tableHeaderSectionHeight()) ?? 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPortfolioTableViewCell") as! MyPortfolioTableViewCell
        
        guard let viewModel = viewModel,
            let cellViewModel = viewModel.cellViewModel(indexPath:indexPath) else {
                return cell
        }
        
        cell.viewModel = cellViewModel
        cellViewModel.setView(cell)
        
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = viewModel?.tableCellBackgroundColor(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (viewModel?.tableCellHeight()) ?? 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSummary", sender: indexPath)
    }
    
}

extension MyPortfolioViewController:MyPortfolioProtocol {
    
    func reloadTable() {
        portfolioTableView.reloadData()
    }
    
    func hideTableView(isHidden:Bool) {
        portfolioTableView.isHidden = isHidden
    }
    
    func showErrorMessage(errorMessage:String)  {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
       showActivityIndicator(onView: view)
    }
    
    func hideLoading() {
        hideActivityIndicator()
    }
    
}


