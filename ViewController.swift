//
//  ViewController.swift
//  NUeScienceCentral
//
//  Created by RYU on 16/7/31.
//  Copyright © 2016 Eddie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoDot: UIImageView!
   
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    //create a active which used to be added to login button
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
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
        self.loginButton.center.x -= self.view.bounds.width
        
        
        
        
        
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
        
        self.loginButton.addSubview(self.spinner)
        self.spinner.startAnimating()
    
     }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

