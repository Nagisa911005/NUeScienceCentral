//
//  PreviewViewController.swift
//  NUeScienceCentral
//
//  Created by RYU on 03/08/2016.
//  Copyright © 2016 Eddie. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    var data: NSDictionary!
    
    @IBOutlet weak var stateImage: UIImageView!
   
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descTextField: UITextField!
    
    @IBOutlet weak var statesTextField: UITextField!
    
    @IBOutlet weak var versionTextField: UITextField!
    
    @IBOutlet weak var PercentageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.nameTextField.text = data["name"] as? String
        self.descTextField.text = data["description"] as? String
        let condition = data["status"] as? String
        if(condition == "Finished"){
            stateImage.image = UIImage(named: "doneicon2")
            self.statesTextField.text = data["status"] as? String
        }else {
        
            stateImage.image = UIImage(named: "undone3")
            self.statesTextField.text = data["status"] as? String
        }
       
        let persentage = data["percentComplete"] as? Int
        let newPersentage = persentage!
        self.PercentageTextField.text = "\(newPersentage)%"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
