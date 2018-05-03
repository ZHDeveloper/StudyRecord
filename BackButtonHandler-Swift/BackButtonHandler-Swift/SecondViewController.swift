//
//  SecondViewController.swift
//  BackButtonHandler-Swift
//
//  Created by ZhiHua Shen on 2018/5/3.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

}

extension SecondViewController: BackButtonHandlerProtocol {
    
    func navigationShouldPopOnBackButton() -> Bool {
        return true
    }
    
}

