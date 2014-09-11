//
//  PeriodicCollectionViewCell.swift
//  Periodic
//
//  Created by James Wilson on 8/28/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit

class PeriodicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
}
