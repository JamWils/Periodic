//
//  FadingLabel.swift
//  Periodic
//
//  Created by James Wilson on 9/9/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit
import QuartzCore

public class FadingLabel: CharacterLabel {
    
//    public override var attributedText: NSAttributedString! {
//        get {
//            return super.attributedText;
//        }
//        
//        set {
//            super.attributedText = newValue
//            self.animateOut() {
//                finished in self.animateIn(nil)
//            }
//        }
//    }
//    
//    override func initialTextLayerAttributes(textLayer: CATextLayer) {
//        textLayer.opacity = 0
//    }
//    
//    public func animateIn(completion: ((finished: Bool) -> Void)?) {
//        for textLayer in characterTextLayers {
//            
//            var duration = (NSTimeInterval(arc4random() % 100)/200.0) + 0.25
//            var delay = NSTimeInterval(arc4random() % 100) / 500.0
//            
//            NoesisLayerAnimation.animation(textLayer, duration:duration, delay:delay, animations: {
//                textLayer.opacity = 1;
//                }, completion:nil)
//            
//        }    }
//    
//    public func animateOut(completion: ((finished: Bool) -> Void)?) {
//        var longestAnimation = 0.0
//        var longestAnimationIndex = -1
//        var index = 0
//        
//        for textLayer in oldCharacterTextLayers {
//            let duration = (NSTimeInterval(arc4random() % 100)/200.0) + 0.25
//            let delay = NSTimeInterval(arc4random() % 100) / 500.0
//            
//            if duration+delay > longestAnimation {
//                longestAnimation = duration+delay
//                longestAnimationIndex = index
//            }
//            
//            NoesisLayerAnimation.animation(textLayer, duration:duration, delay:delay, animations: {
//                textLayer.opacity = 0;
//                }, completion:{ finished in
//                    textLayer.removeFromSuperlayer()
//                    if textLayer == self.oldCharacterTextLayers[longestAnimationIndex] {
//                        if let completionFunction = completion? {
//                            completionFunction(finished: finished)
//                        }
//                    }
//            })
//            
//            ++index
//        }
//    }
    
    override public var attributedText: NSAttributedString! {
        get {
            return super.attributedText
        }
        
        set {
            super.attributedText = newValue
            self.animateOut() { finished in
                self.animateIn(nil);
            }
        }
        
    }
    
    override func initialTextLayerAttributes(textLayer: CATextLayer) {
        textLayer.opacity = 0
    }
    
    func animateIn(completion: ((finished: Bool) -> Void)?) {
        
        for textLayer in characterTextLayers {
            
            var duration = (NSTimeInterval(arc4random()%100)/500.0)+0.25
            var delay = NSTimeInterval(arc4random()%100)/800.0
            
            NoesisLayerAnimation.animation(textLayer, duration:duration, delay:delay, animations: {
                textLayer.opacity = 1;
                }, completion:nil)
            
        }
    }
    
    func animateOut(completion: ((finished: Bool) -> Void)?) {
        
        var longestAnimation = 0.0
        var longestAnimationIndex = -1
        var index = 0
        
        for textLayer in oldCharacterTextLayers {
            
            let duration = (NSTimeInterval(arc4random()%100)/200.0)+0.25
            let delay = NSTimeInterval(arc4random()%100)/500.0
            
            if duration+delay > longestAnimation {
                longestAnimation = duration+delay
                longestAnimationIndex = index
            }
            NoesisLayerAnimation.animation(textLayer, duration:duration, delay:delay, animations: {
                textLayer.opacity = 0;
                }, completion:{ finished in
                    textLayer.removeFromSuperlayer()
                    if textLayer == self.oldCharacterTextLayers[longestAnimationIndex] {
                        if let completionFunction = completion? {
                            completionFunction(finished: finished)
                        }
                    }
            })
            
            ++index
        }
    }

}
