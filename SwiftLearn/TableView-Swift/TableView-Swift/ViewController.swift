//
//  ViewController.swift
//  TableView-Swift
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    var tableView = UITableView?()
    var dataArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for var i = 0;i<100;i++ {
            dataArr.addObject("row\(i)")
        }
        
        var rect = self.view.bounds
        tableView = UITableView(frame: rect, style: UITableViewStyle.Grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellid = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellid) as? UITableViewCell
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellid)
        }
        var s = dataArr.objectAtIndex(indexPath.row) as? String
        
        cell?.textLabel?.text = s
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("row \(indexPath.row)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

