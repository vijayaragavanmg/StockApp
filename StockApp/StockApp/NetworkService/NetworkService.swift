//
//  NetworkService.swift
//  StockApp
//
//  Created by VIJAYARAGAVAN MANOGHARAN on 14/09/19.
//  Copyright © 2019 VIJAYARAGAVAN MANOGHARAN. All rights reserved.
//


import Foundation

class NetworkService:NSObject {
    
    var session:URLSessionProtocol?
    private var dataTask:URLSessionDataTask?
    
    typealias CompletionHandler = (_ error:NSError?,_ data:Data?, _ status: Bool) -> ()
    
    var completionHandler:CompletionHandler? = nil
    
    override init() {
        super.init()
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 45
        sessionConfiguration.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: sessionConfiguration)
    }
    
    
    func processDataTaskService(request:ServiceRequest, completionHandler: @escaping (_ error:NSError?,_ data:Data?, _ status: Bool) -> Void) {
        
        guard let urlString = request.urlString,let url = URL(string: urlString)  else {
            let error = NSError(domain: errorDomain, code:ServiceErrorType.ServiceErrorURLInvalid.rawValue, userInfo: [NSLocalizedDescriptionKey:ErrorDescription.urlNil])
            completionHandler(error, nil, false)
            return
        }
        
        guard let session = session else {
            
            let error = NSError(domain: errorDomain, code:ServiceErrorType.ServiceErrorSessionNil.rawValue, userInfo: [NSLocalizedDescriptionKey:ErrorDescription.sessionNil])
            completionHandler(error, nil, false)
            return
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody =  request.httpBody
        
        request.headerValues.forEach { (k,v) in urlRequest.setValue(v, forHTTPHeaderField: k) }
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            var httpCode = -9800
            if let httpResponse = response as? HTTPURLResponse {
                httpCode = httpResponse.statusCode
            }
            
            if ((httpCode != 200 && httpCode != 204) || error != nil) {
                var err = error
                if httpCode >= 500 {
                    let userInfo = [NSLocalizedDescriptionKey: "Server response timed out. Please try later."]
                    err = NSError(domain: "Error", code: httpCode, userInfo: userInfo)
                }
                completionHandler(err as NSError?,nil,true)
            } else {
                completionHandler(nil,data,false)
            }
        }
        
        task.resume()
    }
    
}

