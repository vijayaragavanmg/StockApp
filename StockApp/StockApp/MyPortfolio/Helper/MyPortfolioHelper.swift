//
//  MyPortfolioHelper.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//

import Foundation

class MyPortfolioHelper: NSObject {
    private var httpHeader:[String:String] = ["Content-Type":"application/json","Authorization":"Bearer C4iENmIBsHUQ5/yo5hg7a1KT9p76iHhKRjVB3Yqe+azLJkU7ZiYfaWIIIjztAokvvZuwctJcKcjShA5kLQEtMg=="]
      private var httpHeader1:[String:String] = [:]
    var networkService:NetworkService?
    var portfolioURL:String = Constants.SeriveURL.portfolioURL1
    
    override init() {
        super.init()
        networkService = NetworkService()
    }
    
    
    //MARK - Get Portfolio List
    func getPortfolioList(completionHandler: @escaping (_ error:NSError?,_ data:[Portfolio]?, _ status: Bool) -> Void) {
        
  
        let bundle = Bundle(for: type(of:self))
          let filePath = bundle.path(forResource: "stockInput", ofType: "json")
          let data = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        var json:[String:AnyObject] = [:]
        do {
             
                   let decoder = JSONDecoder()
                   decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
            json =  try (JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] ?? [:])
                 
        } catch _ as NSError {
                  
               }
        
       let rtaUrl = portfolioURL
       let request = ServiceRequest(rtaUrl , parameterEncoding: .json, httpMethod: .GET, headerFields: httpHeader1)
  
       networkService?.processDataTaskService(request: request) { (error, data, status) in
  
           if let resultData = data {
            
           
            
            
               do {
                   let decoder = JSONDecoder()
                   decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                   let currencyModel = try decoder.decode([Portfolio].self, from: resultData)
                   completionHandler(nil,currencyModel,true)
               } catch let error as NSError {
                   completionHandler(error,nil,false)
               }
           }else {
               completionHandler(error,nil,false)
           }
       }
    }
    
}

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        return formatter
    }()
}

