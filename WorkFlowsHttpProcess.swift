//
//  WorkFlowsHttpProcess.swift
//  NUeScienceCentral
//
//  Created by RYU on 01/08/2016.
//  Copyright © 2016 Eddie. All rights reserved.
//

import Foundation
import UIKit

protocol WorkFlowsHttpProtocol{
    func didReceiveWorkFlowLists(results:NSArray)
}

class WorkFlowHttpController:NSObject{
   
    var delegate:WorkFlowsHttpProtocol?
    
    func workList(url: String){
        
    
        let myUrl: NSURL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: myUrl)
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            
            data, response, error in
            
            if error != nil{
                print("response error ")
                print(error)
            }
            print("****RESPONSE****")
            do{
                
                let jsonArr = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                
                self.delegate?.didReceiveWorkFlowLists(jsonArr)
                
                print("convert to json object start ")
                print("数组个数：\(jsonArr.count)")
                print("convert to json object end")
                
            }catch{
                print("analysis json object failed")
            }
            
            print("****RESPONSE END ****")
        }
        task.resume()
    }
}