//
//  ViewController.swift
//  OC-Swift
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "美女25.jpg")
        
        let imageView = TestImageView(frame: CGRectMake(100, 200, 100, 100))
        
        imageView.image = image
        
        imageView.addTarget(self, withSelector: "imageClick:")
        
        self.view.addSubview(imageView)
        
    }
    func imageClick(sender:TestImageView){
        print("Click")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

