//
//  ViewController.swift
//  NUeScienceCentral
//
//  Created by RYU on 16/7/31.
//  Copyright © 2016年 Eddie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoDot: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set logoImage initial position
        self.logoImage.center.x -= self.view.bounds.width
        //set logoDot initial position
        self.logoDot.center.x -= self.view.bounds.width/2
        
        
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

