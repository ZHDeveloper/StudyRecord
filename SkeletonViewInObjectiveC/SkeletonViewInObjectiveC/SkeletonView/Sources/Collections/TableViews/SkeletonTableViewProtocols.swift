//
//  SkeletonTableViewProtocols.swift
//  SkeletonView-iOS
//
//  Created by Juanpe Catalán on 06/11/2017.
//  Copyright © 2017 SkeletonView. All rights reserved.
//

import UIKit

@objc
public protocol SkeletonTableViewDataSource: UITableViewDataSource {
    @objc optional func numSections(in collectionSkeletonView: UITableView) -> Int
    @objc optional func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    @objc func collectionSkeletonView(_ skeletonView: UITableView, cellIdenfierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
}

public extension SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skeletonView.estimatedNumberOfRows
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int { return 1 }
}

public protocol SkeletonTableViewDelegate: UITableViewDelegate {
}
