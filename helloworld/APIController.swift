//
//  APIController.swift
//  helloworld
//
//  Created by Sudhindra Rao on 10/10/14.
//  Copyright (c) 2014 Sudhindra Rao. All rights reserved.
//

import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class APIController {
    var delegate: APIControllerProtocol?
    init(){
        
    }
    
    func searchItunesFor(searchTerm: String) {
        
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let userPasswordString = "admin:p"
            let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
            let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
            let authString = "Basic \(base64EncodedCredential)"
            config.HTTPAdditionalHeaders = ["Authorization" : authString]
            let session = NSURLSession(configuration: config)
            
            let mingleUrl = "http://localhost:3000/users/1/todos.json"
            let url: NSURL = NSURL(string: mingleUrl)

            let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
                println("Task completed")

                if(error != nil) {
                    println(error.localizedDescription)
                }
                var err: NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray

                if(err != nil) {
                    println("JSON Error \(err!.localizedDescription)")
                }
                
                self.delegate?.didReceiveAPIResults(jsonResult)
            })
            
            task.resume()
        }
    }
    
}
