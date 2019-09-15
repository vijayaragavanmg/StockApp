//
//  View+Stock.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import UIKit

var aiView : UIView?

extension UIViewController {
    func showActivityIndicator(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        aiView = spinnerView
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            aiView?.removeFromSuperview()
            aiView = nil
        }
    }
}
