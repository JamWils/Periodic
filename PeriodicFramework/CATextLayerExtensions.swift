//
//  CATextLayerExtensions.swift
//  Periodic
//
//  Created by James Wilson on 9/9/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit
import QuartzCore

extension CATextLayer {
    convenience init(frame: CGRect, string: NSAttributedString) {
        self.init()
        self.contentsScale = UIScreen.mainScreen().scale
        self.frame = frame
        self.string = string
    }
}
