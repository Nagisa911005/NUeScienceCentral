//
//  WorkListViewController.swift
//  NUeScienceCentral
//
//  Created by RYU on 01/08/2016.
//  Copyright © 2016 Eddie. All rights reserved.
//

import UIKit

class WorkListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, WorkFlowsHttpProtocol{
    
    @IBOutlet weak var tv: UITableView!
    
    var httpProcess:WorkFlowHttpController = WorkFlowHttpController()
    var workListData:NSArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://demo.escapp.net/website-api/rest/workflows"
        httpProcess.delegate = self
        httpProcess.workList(url)

        // Do any additional setup after loading the view.
    }
    
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return workListData.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "workFlows")
        let rowData:NSDictionary = self.workListData[indexPath.row] as! NSDictionary
        
        cell.textLabel?.text = rowData["name"] as? String
        cell.detailTextLabel?.text = rowData["description"] as? String
        cell.imageView?.image = UIImage(named: "workFlowsIcon")
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        return cell
    
    }
    
    // this func is uesd to covert to next page which is show work flow detail page
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dispatch_async(dispatch_get_main_queue(), {self.performSegueWithIdentifier("showDetail", sender: self)})
    }
    
    //this func is used to send the parameter to show work flow detail page
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let index = tv.indexPathForSelectedRow?.row
        //        print(index)
        let detailDict:NSDictionary = self.workListData[index!] as! NSDictionary
        //        print(detailDict)
        let workFlowId = detailDict["id"] as! String
        let detailView = segue.destinationViewController as! ShowDetailViewController
        detailView.workFlowID = workFlowId
        
    }
    
    
    
    
    // this function is used for receive the data from the server
    func didReceiveWorkFlowLists(results: NSArray) {
        
        print("==== WORK LIST ====")
        print("the number of workList:\(results.count)")
        print("===================")
        
        self.workListData = results
        dispatch_async(dispatch_get_main_queue(), {self.tv.reloadData()})
    }
    
    // this func set the 3D animation for table cells
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    // this func set the height for each table cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
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
