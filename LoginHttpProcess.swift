//
//  LoginHttpProcess.swift
//  NUeScienceCentral
//
//  Created by RYU on 01/08/2016.
//  Copyright © 2016 Eddie. All rights reserved.
//

import Foundation
import UIKit

protocol LoginHttpProtocol {
    
    func didReceiveStateCode(statesCode:Int)
}

class LoginHttpController{
    
    var delegate:LoginHttpProtocol?
    
    func loginProcess(userName:String, passWord:String){
        print("LOGIN PROCESSING USERNAME & PASSWORD")
        print(userName)
        print(passWord)
        print("====================================")
        let url = "http://demo.escapp.net/website-api/rest/account/login"
        let myUrl: NSURL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: myUrl)
        request.HTTPMethod = "POST"
        let postString = "username=\(userName)&password=\(passWord)"
        print("LOGIN PROCESSING POST STRING")
        print(postString)
        print("============================")
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        // create a task
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            
            data, response, error in
            
//            print(response)
            
            if error != nil{
                print(error)
            }
            print("****RESPONSE****")
            
            if let httpResponse = response as? NSHTTPURLResponse{
                
                let statesCode = httpResponse.statusCode
                self.delegate?.didReceiveStateCode(statesCode)
                
                print("message status Code\(httpResponse.statusCode)")
                
            }
            
            print("****RESPONSE END ****")
            
        }
        task.resume()
    
    
    }
}
