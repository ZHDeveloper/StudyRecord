//
//  UIViewController+BackButtonHandler.swift
//  BackButtonHandler-Swift
//
//  Created by ZhiHua Shen on 2018/5/3.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import UIKit

@objc public protocol BackButtonHandlerProtocol {
    @objc optional func navigationShouldPopOnBackButton() -> Bool
}

extension UINavigationController: UINavigationBarDelegate {

    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {

        if(self.viewControllers.count < (navigationBar.items?.count ?? 0)) {
            return true
        }
        
        

        var shouldPop: Bool = true
        let vc: UIViewController = self.topViewController!
        
        let sel = NSSelectorFromString("navigationShouldPopOnBackButton")
        
        if(vc.responds(to: sel) && vc.perform(sel) == nil) {
            shouldPop = false
        }

        if(shouldPop) {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        } else {
            for subview in navigationBar.subviews {
                guard 0.0 < subview.alpha && subview.alpha < 1.0 else { return false }
                UIView.animate(withDuration: 0.25, animations: {
                    subview.alpha = 1.0
                })
            }
        }
        return false
    }

}

