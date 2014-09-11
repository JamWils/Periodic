//
//  ArrayCollectionViewDataSource.swift
//  Periodic
//
//  Created by James Wilson on 9/10/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit

public class ArrayCollectionViewDataSource<T: UICollectionViewCell> : NSObject, UICollectionViewDataSource {
    typealias Position = CGPoint
    typealias Distance = CGFloat
    
    let _items: [AnyObject]
    let _cellIdentifer: String
    var _collectionViewCellConfigureBlock: (cell: T, item: AnyObject) -> Void
    
    public init(items: [AnyObject], cellIdentifier: String, collectionViewCellConfigurationBlock: (cell: T, item: AnyObject) -> Void) {
        _items = items
        _cellIdentifer = cellIdentifier
        _collectionViewCellConfigureBlock = collectionViewCellConfigurationBlock
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return _items[indexPath.row];
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _items.count;
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: T = collectionView.dequeueReusableCellWithReuseIdentifier(_cellIdentifer, forIndexPath: indexPath) as T
        
        let item: AnyObject = self.itemAtIndexPath(indexPath)
        _collectionViewCellConfigureBlock(cell: cell, item: item)
        //        let cellContentsEqual: (cell: UICollectionViewCell, item)
        //_collectionViewCellConfigureBlock(cell, item)
        return cell
    }
}
