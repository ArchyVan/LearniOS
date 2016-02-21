//
//  ViewController.swift
//  UI-Swift
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var clickCount:Int = 0
    var tableView:UITableView?
    var dataSoure:NSMutableArray?
    
    func configUI()
    {
        self.tableView! = UITableView()
        tableView?.backgroundColor = UIColor.blueColor()
        
        self.view.addSubview(tableView!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let color = UIColor.redColor()
        self.view!.backgroundColor = color
        
        let rect = CGRectMake(0, 0, 100, 100)
        let myView = UIView(frame: rect)
        myView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(myView)
        
        let myLabel = UILabel(frame: CGRect(x: 100,y: 100,width: 100,height: 100))
        myLabel.text = "First UI"
        self.view.addSubview(myLabel)
        
        let myButton = UIButton(frame: CGRectMake(200, 100, 50, 50))
        myButton.backgroundColor = UIColor.blueColor()
        myButton.setTitle("Touch me", forState:.Normal)
        myButton.addTarget(self, action: "clickedButton:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(myButton)
        
    }
    func clickedButton(sender:UIButton){
        clickCount += 1
        print("click \(clickCount)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

