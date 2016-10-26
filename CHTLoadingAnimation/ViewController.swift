//
//  ViewController.swift
//  CHTLoadingAnimation
//
//  Created by cht on 16/10/26.
//  Copyright © 2016年 cht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var loadingView: CHTLoadView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        
        let loadingView = CHTLoadView.showLoadingIn(view: view)
        self.loadingView = loadingView
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

