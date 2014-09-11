//
//  DragBehavior.swift
//  Periodic
//
//  Created by James Wilson on 9/2/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit

public class DragBehavior: UIDynamicBehavior {
    
    public init(items: [UIDynamicItem], point: CGPoint) {
        super.init()
        for item in items {
            var rectAttachtmentBehavior = RectangleAttachmentBehavior(item: item, point: point)
            self.addChildBehavior(rectAttachtmentBehavior)
        }
        
        
    }
    
    public func updateDragLocation(point: CGPoint) {
        for behavior in self.childBehaviors {
            if let rectAttachtmentBehavior = behavior as? RectangleAttachmentBehavior {
                rectAttachtmentBehavior.updateAttachmentBehavior(point)
            }
        }
    }
    
}
