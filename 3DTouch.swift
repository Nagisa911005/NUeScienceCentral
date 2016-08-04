//
//  3DTouch.swift
//  NUeScienceCentral
//
//  Created by RYU on 03/08/2016.
//  Copyright © 2016 Eddie. All rights reserved.
//

import Foundation
import UIKit

extension ShowDetailViewController: UIViewControllerPreviewingDelegate{
    // this is pop method for 3D touch
    @available(iOS 9.0, *)
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?{
    
        guard let indexPath = tv.indexPathForRowAtPoint(location),
            cell = tv.cellForRowAtIndexPath(indexPath) else {return nil}
        
        
        guard let previewVC = storyboard?.instantiateViewControllerWithIdentifier("previewVC") as? PreviewViewController else {return nil}
        
        previewVC.data = details[indexPath.row] as! NSDictionary
       
        
        
        previewVC.preferredContentSize = CGSize(width: 400, height: 400)
        
        previewingContext.sourceRect = cell.frame
        
        return previewVC
    
    }
    
    
    // this is peek method for 3D touch 
    @available(iOS 9.0, *)

    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController){
    
    }

}
