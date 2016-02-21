//
//  RootViewController.swift
//  Navigation-Swift
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import Foundation
import UIKit

class RootViewController : UIViewController,FontSizeChangeDelegate {
    
    var myLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Root"
        
        let nextItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "nextPage")
        
        self.navigationItem.rightBarButtonItem = nextItem
        
        let rect = CGRectMake(0, 100, 320, 44)
        myLabel = UILabel(frame: rect)
        myLabel?.text = "iOS/Swift"
        
        self.view.addSubview(myLabel!)
    }
    
    func nextPage(){
        
        let sub:SubViewController = SubViewController()
        sub.delegate = self
        self.navigationController?.pushViewController(sub, animated:true)
    }
    
    func fontSizeDidChange(controller: SubViewController, fontsize: Int) {
        
        var font = UIFont.systemFontOfSize(CGFloat(fontsize))
        
        myLabel?.font = font
    }
}