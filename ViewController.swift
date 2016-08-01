//
//  ViewController.swift
//  NUeScienceCentral
//
//  Created by RYU on 16/7/31.
//  Copyright © 2016 Eddie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LoginHttpProtocol{

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoDot: UIImageView!
   
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var warningMessage: UIImageView!
   
    
    //CUSTOM
    //set the initial point of loginbutton position
    var loginButtonPosition = CGPoint.zero
    
    var loginStateCode:Int = 0
    var loginHttpProcess: LoginHttpController = LoginHttpController()
 
    
    //create a active indicator which used to be added to login button
//    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
//    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set logoImage initial position
        self.logoImage.center.x -= self.view.bounds.width
        //set logoDot initial position
        self.logoDot.center.x -= self.view.bounds.width/2
        
        
        
        
        // add the padding for the username text field
        let userPaddingView = UIView(frame: CGRectMake(0, 0, 73, self.usernameTextField.frame.height))
        self.usernameTextField.leftView = userPaddingView
        self.usernameTextField.leftViewMode = .Always
        // set the initial position of username text field
        self.usernameTextField.center.x -= self.view.bounds.width
        // set the initial position of user icon
        self.userIcon.center.x -= self.view.bounds.width

        
        //add the padding fot the password text field
        let passwordPaddingView = UIView(frame: CGRectMake(0, 0, 73, self.passwordTextField.frame.height))
        self.passwordTextField.leftView = passwordPaddingView
        self.passwordTextField.leftViewMode = .Always
        // set the initial position of password text field
        self.passwordTextField.center.x -= self.view.bounds.width
        // set the password icon initial position
        self.passwordIcon.center.x -= self.view.bounds.width
        
        //set login button initial position
        self.loginButtonPosition = self.loginButton.center
        self.loginButton.center.x -= self.view.bounds.width
        
        //set the initial state of activity indicator
        self.spinner.hidden = true
        //set the initial state of ImageView of warning message
        self.warningMessage.hidden = true
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        //using the animation for the logo appear 
        UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
                self.logoImage.center.x += self.view.bounds.width
            }, completion: nil)
        
        //using the animation for the logoDot appear
        UIView.animateWithDuration(5, delay: 0.4, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: [], animations: {
                self.logoDot.center.x += self.view.bounds.width/2
            }, completion: nil)
        
        //using the animation for username text field
        UIView.animateWithDuration(0.4, delay: 0.5, options: .CurveEaseOut, animations: {
                self.usernameTextField.center.x += self.view.bounds.width
                self.userIcon.center.x += self.view.bounds.width
            }, completion: nil)
        
        //using the animation for password text field
        UIView.animateWithDuration(0.4, delay: 0.6, options: .CurveEaseOut, animations: {
                self.passwordTextField.center.x += self.view.bounds.width
                self.passwordIcon.center.x += self.view.bounds.width
            }, completion: nil)
        
        //creating the animation for login button
        UIView.animateWithDuration(0.4, delay: 0.7, options: .CurveEaseOut, animations: {
                self.loginButton.center.x += self.view.bounds.width
            }, completion: nil)
        
        
    }
    
    
    //when click on the login button which will using the following fucn 
    @IBAction func logInProcessing(sender: AnyObject) {
        //set the state of activity indicator
        self.spinner.hidden = false
        //set the style of activity indicator
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        //let activity indicator start animating
        self.spinner.startAnimating()
        
        
        //set the animation of login button when we touch the button
       
        UIView.animateWithDuration(0.3, animations: {
            self.loginButton.center = self.loginButtonPosition
        })
        self.loginButton.center.x -= 30
        self.spinner.center.x -= 30
        
        //reset the state of login buttom and warning message
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
                self.loginButton.center.x += 30
                self.spinner.center.x += 30
            }, completion: nil)
        
        UIView.transitionWithView(self.warningMessage, duration: 0.3, options: [.TransitionFlipFromTop, .CurveEaseOut], animations: {
            self.warningMessage.hidden = true
            }, completion: nil)
        
        
        //get the username and password from text field
        let userName = usernameTextField.text
        let passWord = passwordTextField.text
        print("****USERNAME & PASSWORD****")
        print(userName)
        print(passWord)
        print("***************************")
        
        //estimate the username and password whether has the value
        if(userName!.isEmpty || passWord!.isEmpty){
            
            alertMessage("** ALL FIELDS ARE REQUIRED !!! **")
        }else{
            
            loginHttpProcess.delegate = self
            loginHttpProcess.loginProcess(userName!, passWord: passWord!)
        }
    
    }
    
    func didReceiveStateCode(statesCode: Int) {
        
        print("delegate")
        print(statesCode)
        
        if(statesCode == 200){
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("login", sender: self)
            }
        }else if(statesCode == 400){
            
            dispatch_async(dispatch_get_main_queue()) {
                
                
                UIView.animateWithDuration(0.3, animations: {
                    self.loginButton.center.y += 72
                    self.spinner.hidden = true
                    }, completion: {
                        _ in
                        
                        UIView.transitionWithView(self.warningMessage, duration: 0.3, options: [.TransitionFlipFromTop, .CurveEaseOut], animations: {
                                self.warningMessage.hidden = false
                            }, completion: nil)
                })
            
            }
            
        }else{
            
            alertMessage("** SORRY SERVER CRASHED TRY AGAIN LATER !!! **")
        
        }
        
        
    }
    
    func alertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title: "ALERT", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

