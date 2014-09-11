//
//  PeriodicCollectionViewFlowLayout.swift
//  Periodic
//
//  Created by James Wilson on 8/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit
import QuartzCore
import PeriodicFramework


class PeriodicCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let horizontalSpacing:Double = 5
    var verticalSpacing:Double = 5
    var columns:Double = 18
    var rows:Double = 10
    var indexPathRow = 0
    var rowCount = 0
    var columnCount = 0
    let totalCount = 118
    
    private var _animator: UIDynamicAnimator?
    private var _dragBehavior: DragBehavior?
    private var _indexPathToDrag: NSIndexPath?
    
    let elementLocations:[Int:[Int]] = [
        0:[0,                                                        17],
        1:[0, 1,                                 12, 13, 14, 15, 16, 17],
        2:[0, 1,                                 12, 13, 14, 15, 16, 17],
        3:[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17],
        4:[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17],
        5:[0, 1,    3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17],
        6:[0, 1,    3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17],
        7:[                                                            ],
        8:[      2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,   ],
        9:[      2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,   ]
    ]
    
    override init() {
        super.init()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func initialize() {
        self.scrollDirection = .Horizontal
        self.registerClass(BlankCollectionReusableView.self, forDecorationViewOfKind: "BlankView")
    }
    
    override func collectionViewContentSize() -> CGSize {
        self.minimumLineSpacing = 10
        self.itemSize = calculateItemSize()
        self.collectionView?.backgroundColor = UIColor.clearColor()
        return CGSize(width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height - 20)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject] {
//        var layoutAttributes = [AnyObject]()
        var layoutAttributes = super.layoutAttributesForElementsInRect(rect)
        
        var j = 0
        for var i = 0; i < 180; i++ {
            if let numbers = elementLocations[rowCount] {
                let indexPath = NSIndexPath(forItem:i, inSection:0)
                
                if shouldAddFrame(indexPath) {
                    layoutAttributes?.append(self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem:j, inSection:0)))
                    j++
                    
                }
            }
            
        }
        
        columnCount = 0
        rowCount = 0
        
        for item in layoutAttributes! {
            if let cellAttributes = item as? UICollectionViewLayoutAttributes {
//                self.applyPinchToLayoutAttributes(cellAttributes)
            }
        }

        
       
        return layoutAttributes!
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = calculateFrame(indexPath)
        
        return attributes
    }
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, withIndexPath: indexPath)
        attributes.frame = calculateFrame(indexPath)
        
        return attributes
    }
    
    func calculateItemSize() -> CGSize {
        let width = Float(self.collectionView!.bounds.size.width)
        let cellWidth  = Double(width - Float(horizontalSpacing * columns)) / columns
        let height = Float(self.collectionView!.bounds.size.height)
        let cellHeight = Double(height - Float(verticalSpacing * rows)) / rows
        
        let finalLength:Double = min(cellWidth, cellHeight)

        return CGSize(width: CGFloat(finalLength), height: CGFloat(finalLength))
    }

    func shouldAddFrame(indexPath: NSIndexPath) -> Bool {
        var result = false
        
        
        if let numbers = elementLocations[rowCount] {
            for number in numbers {
                if number == columnCount {
                    result = true
                    break
                }
            }
            
            if(indexPath.row > 0 && columnCount == 17) {
                rowCount++
                columnCount = 0
            } else {
                columnCount++
            }
            
            
        } else {
            rowCount++
        }
        
        if rowCount == 5 && columnCount == 3 {
            rowCount = 8
            columnCount = 0
        } else if rowCount == 9 && columnCount == 0 {
            rowCount = 5
            columnCount = 3
        } else if rowCount == 6 && columnCount == 3 {
            rowCount = 9
            columnCount = 0
        } else if rowCount == 10 && columnCount == 0 {
            rowCount = 6
            columnCount = 3
        }
        
        return result
    }
    
    func calculateFrame(indexPath: NSIndexPath) -> CGRect{
        var size = self.itemSize
        
        var x = 0.0
        var y = abs((Double(self.collectionView!.contentSize.height) - (verticalSpacing  + Double(size.height) * Double(rows))) / 4.0)
        if columnCount > 0 {
            x = (horizontalSpacing + Double(size.width)) * Double(columnCount - 1)
            y += (verticalSpacing + Double(size.height)) * Double(rowCount)
        } else {
            x = (horizontalSpacing + Double(size.width)) * Double(17)
            y += (verticalSpacing + Double(size.height)) * Double(rowCount - 1)
        }
        
        return CGRectMake(CGFloat(x), CGFloat(y), size.width, size.height)
    }
    
    func setDraggedIndexPath(indexPath: NSIndexPath, point: CGPoint) {
        _animator = UIDynamicAnimator(collectionViewLayout: self)
        _indexPathToDrag = indexPath
        
        var draggable: [UICollectionViewLayoutAttributes];
        var attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        attributes.zIndex = 1;
        
        _dragBehavior = DragBehavior(items: [attributes], point: point)
        _animator?.addBehavior(_dragBehavior)
        
    }
    
    func updateDragLocation(point: CGPoint) {
        _dragBehavior?.updateDragLocation(point)
    }
    
    func clearDraggedIndexPaths() {
        _animator = nil
        _indexPathToDrag = nil
    }
}
