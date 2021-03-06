//
//  NoesisLayerAnimation.swift
//  Periodic
//
//  Created by James Wilson on 9/9/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import Foundation
import QuartzCore

class NoesisLayerAnimation: NSObject {
    var completionClosure: ((finished: Bool)-> ())?
    var layer: CALayer!
    
    class func animation(layer: CALayer, duration: NSTimeInterval, delay: NSTimeInterval, animations: (() -> ())?, completion: ((finished: Bool)-> ())?) -> NoesisLayerAnimation {
        
        var animation = NoesisLayerAnimation()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            var animationGroup: CAAnimationGroup?
            let oldLayer = self.animatableLayerCopy(layer)
            animation.completionClosure = completion
            animation.layer = layer;
            
            if let layerAnimations = animations? {
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                layerAnimations()
                CATransaction.commit()
            }
            
            animationGroup = self.groupAnimationsForDifferences(oldLayer, newLayer: layer)
            
            if let differenceAnimation = animationGroup? {
                differenceAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                differenceAnimation.duration = duration
                differenceAnimation.beginTime = CACurrentMediaTime()
                differenceAnimation.delegate = animation
                layer.addAnimation(differenceAnimation, forKey: nil)
            }else{
                if let completion = animation.completionClosure? {
                    completion(finished: true)
                }
            }
        };
        
        return animation
    }
    
    class func groupAnimationsForDifferences(oldLayer: CALayer, newLayer: CALayer) -> CAAnimationGroup? {
        var animationGroup: CAAnimationGroup?
        var animations = Array<CABasicAnimation>()
        
        if !CATransform3DEqualToTransform(oldLayer.transform, newLayer.transform) {
            var animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(CATransform3D: oldLayer.transform)
            animation.toValue = NSValue(CATransform3D: newLayer.transform)
            animations.append(animation)
        }
        
        if !CGRectEqualToRect(oldLayer.bounds, newLayer.bounds) {
            var animation = CABasicAnimation(keyPath: "bounds")
            animation.fromValue = NSValue(CGRect: oldLayer.bounds)
            animation.toValue = NSValue(CGRect: newLayer.bounds)
            animations.append(animation)
        }
        
        if !CGRectEqualToRect(oldLayer.frame, newLayer.frame) {
            var animation = CABasicAnimation(keyPath: "frame")
            animation.fromValue = NSValue(CGRect: oldLayer.frame)
            animation.toValue = NSValue(CGRect: newLayer.frame)
            animations.append(animation)
        }
        
        if !CGPointEqualToPoint(oldLayer.position, newLayer.position) {
            var animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue(CGPoint: oldLayer.position)
            animation.toValue = NSValue(CGPoint: newLayer.position)
            animations.append(animation)
        }
        
        if oldLayer.opacity != newLayer.opacity {
            var animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animations.append(animation)
        }
        
        if animations.count > 0 {
            animationGroup = CAAnimationGroup()
            animationGroup!.animations = animations
        }
        
        return animationGroup
    }
    
    class func animatableLayerCopy(layer: CALayer) -> CALayer {
        
        var layerCopy = CALayer()
        
        layerCopy.opacity = layer.opacity
        layerCopy.transform = layer.transform
        layerCopy.bounds = layer.bounds
        layerCopy.position = layer.position
        
        return layerCopy;
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if let completion = completionClosure? {
            completion(finished: true)
        }
    }
}
