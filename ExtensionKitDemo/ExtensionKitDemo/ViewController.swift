//
//  ViewController.swift
//  ExtensionKitDemo
//
//  Created by ZhiHua Shen on 2018/6/12.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import UIKit
import ExtKit

struct Person: Codable {
    var name: String?
    var age: Int?
}

class Student {
    var name: String?
    var age: Int?

}

class ViewController: UIViewController, Nibable {
    
    @IBOutlet weak var centerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let person = Person(name: "张三", age: 4)
//
//        ValueDefaults[Key<Person>("k_person")] = person
//
//        let psn = ValueDefaults[Key<Person>("k_person")]
//
//        print(psn ?? "")
        
        centerView.corner(withRadius: 50)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        let view = SubView.loadFromNib()
//
//        let vc = ViewController.initialFrom(storyboard: "Main")

//        let vc = SecondViewController.instantiateFrom(storyboard: "Main")
        
//        print(vc)
    }

}
