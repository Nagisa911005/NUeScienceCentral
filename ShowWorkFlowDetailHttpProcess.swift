//
//  ShowWorkFlowDetailHttpProcess.swift
//  NUeScienceCentral
//
//  Created by RYU on 02/08/2016.
//  Copyright © 2016 Eddie. All rights reserved.
//

import Foundation
import UIKit

protocol DetailHttpProtocol{
    
    func didReceiveWorkFlowDetail(details:NSArray)
}


class DetailHttpController:NSObject{

    var delegate:DetailHttpProtocol?
    
    func showDetail(url:String){
    
        let myUrl: NSURL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: myUrl)
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            
            data, response, error in
            
            if error != nil{
                print("*** REPONSE ERROR ***")
                print(error)
            }
            
            print("****RESPONSE****")
            do{
                
                let jsonArr = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                
                self.delegate?.didReceiveWorkFlowDetail(jsonArr)
                
                print("*** Convert To Json Object Start ***")
                print("数组个数：\(jsonArr.count)")
                print("*** Convert To Json Object End ***")
                
            }catch{
                print("*** Analysis Json Object Failed ***")
            }
            
            print("****RESPONSE END ****")
        }
        task.resume()
        
    }
    
    
}



