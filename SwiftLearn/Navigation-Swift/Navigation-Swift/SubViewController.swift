//
//  SubViewController.swift
//  Navigation-Swift
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import Foundation
import UIKit

protocol FontSizeChangeDelegate:NSObjectProtocol{
    func fontSizeDidChange(controller:SubViewController,fontsize:Int)
}

class SubViewController : UIViewController {
    
    var fontSize:Int = 20
    
    var delegate:FontSizeChangeDelegate?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        self.navigationItem.title="Sub"
        
        let myButton = UIButton(type: .System)
        
        let frame = CGRectMake(0, 64, 375, 100)
        myButton.frame = frame
        myButton.setTitle("Back Root", forState: UIControlState.Normal)
        myButton.addTarget(self, action: "Back", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(myButton)

    }
    func Back() {
        self.navigationController?.popViewControllerAnimated(true)
        fontSize++;
        if ((delegate) != nil){
            
            delegate?.fontSizeDidChange(self, fontsize: fontSize)
        }
        
    }
}