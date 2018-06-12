//
//  Nibable.swift
//  ExtKit
//
//  Created by ZhiHua Shen on 2018/6/12.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import UIKit

public protocol Nibable { }

public extension Nibable where Self: UIView {
    
    /// Creating view objects from Nib will cause crashes when Nib does not exist.
    static func loadFromNib() -> Self {
        let nibName = String(describing: self)
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.last as! Self
    }
}

public extension Nibable where Self: UIViewController {
    
    static func instantiateFrom(storyboard: String) -> Self {
        let id = String(describing: self)
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: id) as! Self
    }
    
    static func initialFrom(storyboard: String) -> Self {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateInitialViewController() as! Self
    }
}


