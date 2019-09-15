//
//  SummaryViewController.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 15/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import UIKit
import Charts

class SummaryViewController: UIViewController {

    @IBOutlet weak var chart: LineChartView!
    var selectedPortfolio:Portfolio?
    var dataSet: LineChartDataSet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


   func getPortfolios()->[Double] {
    return []
    }
}



extension SummaryViewController {
    
    func setGraph() {
        let values: [Double] = getPortfolios()
        
        var entries: [ChartDataEntry] = Array()
        
        for (i, value) in values.enumerated()
        {
            entries.append(ChartDataEntry(x: Double(i), y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
        }
        
        dataSet = LineChartDataSet(entries: entries, label: "First unit test data")
        dataSet.drawIconsEnabled = false
        dataSet.iconsOffset = CGPoint(x: 0, y: -20.0)
        dataSet.mode = LineChartDataSet.Mode.horizontalBezier
        
         let leftAxis = chart.leftAxis
        leftAxis.labelTextColor = UIColor.white
        chart.animate(xAxisDuration: 3, yAxisDuration: 3)
        chart.backgroundColor = NSUIColor.clear
        chart.leftAxis.axisMinimum = 0.0
        chart.rightAxis.axisMinimum = 0.0
        chart.data = LineChartData(dataSet: dataSet)
        chart.isUserInteractionEnabled = false
    }
    
}
