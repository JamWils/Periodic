//
//  ArrayCollectionViewDataSourceTests.swift
//  Periodic
//
//  Created by James Wilson on 9/10/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit
import XCTest
import PeriodicFramework

class ArrayCollectionViewDataSourceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfRowsInSectionZeroIsTwo() {
        class MockUICollectionView : UICollectionView {
            
        }
        
        let items = ["a", "b"];
        let identifier = "cell"
        func cellBlock (cell: UICollectionViewCell, item: AnyObject) -> Void {
            
        }
        
        let mockCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout());
        
        let dataSource = ArrayCollectionViewDataSource<UICollectionViewCell>(items: items, cellIdentifier: identifier, collectionViewCellConfigurationBlock: cellBlock)
        mockCollectionView.dataSource = dataSource;
        let numberOfRows = dataSource.collectionView(mockCollectionView, numberOfItemsInSection: 0);
        
        XCTAssertEqual(items.count, numberOfRows, "Number of items in section zero should be 2");
        
    }
    
    func testCellConfiguration() {
        
        var cell: UICollectionViewCell = UICollectionViewCell()
        class MockUICollectionView : UICollectionView {
            override func dequeueReusableCellWithReuseIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath!) -> AnyObject {
                let cell = UICollectionViewCell()
                return cell
            }
        }
        
        var configuredCell: UICollectionViewCell?
        var configuredObject: AnyObject?
        
        let items = ["a", "b"];
        let identifier = "cell"
        func cellBlock (cell: UICollectionViewCell, item: AnyObject) -> Void {
            configuredCell = cell;
            configuredObject = item;
        }
        
        let mockCollectionView = MockUICollectionView(frame: CGRect(x: 0, y: 0, width: 110, height: 110), collectionViewLayout: UICollectionViewFlowLayout());
        mockCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        let newTestCell = mockCollectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as UICollectionViewCell
        
        let dataSource = ArrayCollectionViewDataSource<UICollectionViewCell>(items: items, cellIdentifier: identifier, collectionViewCellConfigurationBlock: cellBlock)
        mockCollectionView.dataSource = dataSource;
        
        let result = dataSource.collectionView(mockCollectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0));
        let objectString: String = configuredObject as String!
        
        
        XCTAssertEqual(result, cell, "Should return the dummy cell")
        XCTAssertEqual(configuredCell!, cell, "This should ahve been passed to the block")
        XCTAssertEqual(objectString, "a", "This should have been passed to the block")
        
    }

}
