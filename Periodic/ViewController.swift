//
//  ViewController.swift
//  Periodic
//
//  Created by James Wilson on 8/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit
import PeriodicFramework


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
                            
    @IBOutlet weak var periodicCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    var elementLabel: FadingLabel!
    
    var periodicLayout: PeriodicCollectionViewFlowLayout?
    var elements:[Element] = [Element]()
    
    private var _startIndexPath: NSIndexPath?
    private var _cellToMove: UICollectionViewCell?
    private var _snapBackPoint: CGPoint?
    private var _animator: UIDynamicAnimator?
    private var _snapBehavior: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementLabel = FadingLabel(frame: CGRect(x: 300, y: 10, width: 300, height: 100))
        elementLabel!.font = UIFont.systemFontOfSize(48.0)
        elementLabel!.textAlignment = NSTextAlignment.Center
        elementLabel!.textColor = UIColor.whiteColor()
        self.view.addSubview(elementLabel)
        
        
        _animator = UIDynamicAnimator(referenceView: periodicCollectionView)
        
        periodicCollectionView.dataSource = self
        periodicCollectionView.delegate = self
        periodicLayout = periodicCollectionView.collectionViewLayout as? PeriodicCollectionViewFlowLayout

        let data = JSONElementParser.loadElementsFromBundle()
        if let validData = data {
            let parser = JSONElementParser(data: validData)
            elements = parser.elements
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as PeriodicCollectionViewCell
        
        switch indexPath.row + 1 {
            //        case 1, 6, 7, 8, 15, 16, 34:
            //            cell.contentView.backgroundColor = UIColor.grayColor()
            //            break
            //        case 2, 10, 18, 36, 54, 86:
            //            cell.contentView.backgroundColor = UIColor.purpleColor()
            //            break
            //        case 3, 11, 19, 37, 55, 87:
            //            cell.contentView.backgroundColor = UIColor.greenColor()
            //            break
            //        case 4, 12, 20, 38, 56, 88:
            //            cell.contentView.backgroundColor = UIColor.yellowColor()
            //            break
            //        case 5, 14,32, 33, 51, 52, 84:
            //            cell.contentView.backgroundColor = UIColor.redColor()
            //            break
        default:
            cell.contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
            break
        }
        
        cell.numberLabel.text = String(elements[indexPath.row].atomicNumber)
        cell.symbolLabel.text = elements[indexPath.row].symbol;
        
        return cell
    }

    @IBAction func moveCell(panGesture: UIPanGestureRecognizer) -> (Void) {
        var touchLocation = panGesture.locationInView(periodicCollectionView)
        
        switch (panGesture.state) {
        case .Began:
            _startIndexPath = periodicCollectionView.indexPathForItemAtPoint(touchLocation)
            
            if let indexPath = _startIndexPath? {
                var cell = periodicCollectionView.cellForItemAtIndexPath(indexPath)
                elementLabel!.text = elements[indexPath.row].name;
                println("\(elementLabel!.text) \(elements[indexPath.row].name)")
                if let cellToMove = cell? {
                    _cellToMove = cellToMove
                    _snapBackPoint = CGPointMake(cellToMove.center.x, cellToMove.center.y)
                }
            }
            
            break
        case .Changed:
            if let cellToMove = _cellToMove {
                let offset = panGesture.translationInView(cellToMove)
                let center = cellToMove.center
                
                cellToMove.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
                panGesture.setTranslation(CGPoint.zeroPoint, inView: cellToMove)
            }

            break
        case .Ended:
            if let cellToMove = _cellToMove {
                
                if let animator = _animator? {
                    if let snapBehavior = _snapBehavior? {
                        animator.removeBehavior(snapBehavior)
                    }
                    
//                    elementLabel!.text = ""
                    if let snapBackPoint = _snapBackPoint? {
                        _snapBehavior = UISnapBehavior(item: cellToMove, snapToPoint: snapBackPoint)
                        animator.addBehavior(_snapBehavior)
                    }
                }
            }
            
            
            _startIndexPath = nil
            _cellToMove = nil
            
            break
        default:
            break
        }
    }
}
