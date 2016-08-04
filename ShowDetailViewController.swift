//
//  ShowDetailViewController.swift
//  NUeScienceCentral
//
//  Created by RYU on 01/08/2016.
//  Copyright © 2016 Eddie. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailHttpProtocol{
    
    @IBOutlet weak var tv: UITableView!
   
    var workFlowID:NSString = NSString()
    var httpProcess: DetailHttpController = DetailHttpController()
    var details:NSArray = NSArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url =  "http://demo.escapp.net/website-api/rest/workflows/\(workFlowID)/invocations"
        httpProcess.delegate = self
        httpProcess.showDetail(url)
        
        //check the device whether support the 3D touch founction
        if traitCollection.forceTouchCapability == .Available {
            registerForPreviewingWithDelegate(self, sourceView: tv)
        }
        
        
    }
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return details.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "workFlowDeatil")
        let rowData:NSDictionary = self.details[indexPath.row] as! NSDictionary
        cell.textLabel?.text = rowData["name"] as? String
        
        let description = rowData["description"] as? String
        let percentComplete = rowData["percentComplete"] as? Int
        let newDescription = description!
        let newPercentage = percentComplete!
        
        
        let workFlowDescription = "\(newDescription) AND Percentage:\(newPercentage)%"
        let states = rowData["status"] as? String
        
        cell.detailTextLabel?.text = workFlowDescription
        
        if(states == "Finished"){
            
            cell.imageView?.image = UIImage(named: "doneIcon")
        
        }else{
            
            cell.imageView?.image = UIImage(named: "undoneIcon")
        
        }
        
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        return cell
    
    
    }
    
    func didReceiveWorkFlowDetail(details: NSArray) {
        self.details = details;
        if(details.count == 0){
            
            alertMessage("** SORRY YOU HAVEN'T RUN THIS WORKFLOW BEFORE **")
       
        }
        print(details.count)
        dispatch_async(dispatch_get_main_queue(), {self.tv.reloadData()})
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
