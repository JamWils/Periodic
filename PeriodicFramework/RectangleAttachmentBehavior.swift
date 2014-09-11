//
//  RectangleAttachmentBehavior.swift
//  Periodic
//
//  Created by James Wilson on 9/2/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit

class RectangleAttachmentBehavior: UIDynamicBehavior {
    
    init(item: UIDynamicItem, point: CGPoint) {
        super.init()
        
        let topLeft = CGPoint(x: (point.x - 50.0) / 2.0, y: (point.y - 50.0) / 2.0)
        
        var attachmentBehavior = UIAttachmentBehavior(item: item, attachedToAnchor: topLeft)
        attachmentBehavior.frequency = 1.0
        attachmentBehavior.damping = 1.0
        self.addChildBehavior(attachmentBehavior)
    }
    
    func updateAttachmentBehavior(point: CGPoint) {
        let topLeft = CGPoint(x: (point.x - 50.0) / 2.0, y: (point.y - 50.0) / 2.0)
        var attatchmentBehavior = self.childBehaviors[0] as UIAttachmentBehavior
        attatchmentBehavior.anchorPoint = topLeft
    }
    
    
}
