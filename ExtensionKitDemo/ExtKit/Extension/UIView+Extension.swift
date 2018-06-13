//
//  UIImageView+Extension.swift
//  ExtKit
//
//  Created by ZhiHua Shen on 2018/6/13.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Rounding the view object
    ///
    /// - Parameter radius: radius
    func corner(withRadius radius: CGFloat) {
        
        let bezierPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        
        self.layer.mask = shapeLayer
    }
    
}
