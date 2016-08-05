//
//  ViewController.swift
//  DRModalViewDemo
//
//  Created by dengrui on 16/8/5.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareClick(sender: AnyObject) {
        /// 这里传要分享的参数
        YRPShareView.showWithParams(["":""])
    }

    @IBAction func addAndReduce(sender: AnyObject) {
        /**
        *  最大可购买数量 只要998 商品id 商品期数
        */
        YRPAddProductCountView.show(998, goodsId: 4, periodNo: "4")
    }
    
    
}

