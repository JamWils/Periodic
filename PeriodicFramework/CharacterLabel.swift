//
//  CharacterLabel.swift
//  Periodic
//
//  Created by James Wilson on 9/8/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import UIKit
import QuartzCore
import CoreText

public class CharacterLabel: UILabel, NSLayoutManagerDelegate {

//    let textStorage = NSTextStorage(string: " ");
//    let textContainer = NSTextContainer();
//    let layoutManager = NSLayoutManager();
//    
//    var oldCharacterTextLayers = [CATextLayer]()
//    var characterTextLayers = [CATextLayer]()
//    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupLayoutManager()
//    }
//    
//    public required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
////        setupLayoutManager()
//    }
//    
//    public override func awakeFromNib() {
//        super.awakeFromNib()
//        setupLayoutManager()
//    }
//    
//    public override var text: String! {
//        get {
//            return super.text
//        }
//        
//        set {
//            let wordRange = NSMakeRange(0, newValue.utf16Count)
//            var attributedText = NSMutableAttributedString(string: newValue)
//            attributedText.addAttribute(NSForegroundColorAttributeName , value:self.textColor, range:wordRange)
//            attributedText.addAttribute(NSFontAttributeName , value:self.font, range:wordRange)
//            
//            var paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.alignment = self.textAlignment
//            attributedText.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range: wordRange)
//            
//            self.attributedText = attributedText
//        }
//        
//    }
//    
//    public override var attributedText: NSAttributedString! {
//        get {
//            return super.attributedText
//        }
//        
//        set {
//            
//            if textStorage.string == newValue.string {
//                return
//            }
//            
//            cleanOutOldCharacterTextLayers()
//            oldCharacterTextLayers = [CATextLayer](characterTextLayers)
//            textStorage.setAttributedString(newValue)
//        }
//        
//    }
//    
//    func setupLayoutManager() {
//        textStorage.addLayoutManager(layoutManager)
//        layoutManager.addTextContainer(textContainer)
//        textContainer.size = bounds.size
//        textContainer.maximumNumberOfLines = numberOfLines
//        textContainer.lineBreakMode = lineBreakMode
//        layoutManager.delegate = self
//    }
//    
//    public func layoutManager(layoutManager: NSLayoutManager!, didCompleteLayoutForTextContainer textContainer: NSTextContainer!, atEnd layoutFinishedFlag: Bool) {
//        calculateTextLayers()
//    }
//    
//    func calculateTextLayers() {
//        characterTextLayers.removeAll(keepCapacity: false)
//
//        let wordRange = NSMakeRange(0, textStorage.string.utf16Count)
//        let attributedString = self.internalAttributedText()
//        let layoutRect = layoutManager.usedRectForTextContainer(textContainer)
//        
//        //This should be a while loop
//        for var index = wordRange.location; index < wordRange.length + wordRange.location; index += 0 {
//            let glyphRange = NSMakeRange(index, 1)
//            let characterRange = layoutManager.characterRangeForGlyphRange(glyphRange, actualGlyphRange: nil)
//            let textContainer = layoutManager.textContainerForGlyphAtIndex(index, effectiveRange: nil)
//            var glyphRect = layoutManager.boundingRectForGlyphRange(glyphRange, inTextContainer: textContainer!)
//            
//            var location = layoutManager.locationForGlyphAtIndex(index)
//            
//            var kerningRange = layoutManager.rangeOfNominallySpacedGlyphsContainingIndex(index)
//            
//            if kerningRange.location == index {
//                if countElements(characterTextLayers) > 0 {
//                    var previousLayer = characterTextLayers[characterTextLayers.endIndex - 1]
//                    var previousLayerFrame = previousLayer.frame
//                    previousLayerFrame.size.width += CGRectGetMaxX(glyphRect) - CGRectGetMaxX(previousLayerFrame)
//                    previousLayer.frame = previousLayerFrame
//                }
//            }
//            
//            glyphRect.origin.y += location.y - (glyphRect.height / 2) + (self.bounds.size.height / 2) - (layoutRect.size.height / 2)
//            
//            var textLayer = CATextLayer(frame: glyphRect, string: attributedString.attributedSubstringFromRange(characterRange))
//            initialTextLayerAttributes(textLayer)
//            characterTextLayers.append(textLayer)
//            
//            index += characterRange.length
//        }
//        
//    }
//    
//    func initialTextLayerAttributes(textLayer: CATextLayer) {
//        
//    }
//    
//    func internalAttributedText() -> NSMutableAttributedString! {
//        let wordRange = NSMakeRange(0, textStorage.string.utf16Count);
//        var attributedText = NSMutableAttributedString(string: textStorage.string);
//        attributedText.addAttribute(kCTForegroundColorAttributeName as NSString , value:self.textColor.CGColor, range:wordRange);
//        attributedText.addAttribute(kCTFontAttributeName as NSString , value:self.font, range:wordRange);
//        
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = self.textAlignment
//        attributedText.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range: wordRange)
//        
//        return attributedText;
//    }
//    
//    func cleanOutOldCharacterTextLayers() {
//        for textLayer in oldCharacterTextLayers {
//            textLayer.removeFromSuperlayer();
//        }
//
//        oldCharacterTextLayers.removeAll(keepCapacity: false);
//    }

    let textStorage = NSTextStorage(string: " ");
    let textContainer = NSTextContainer();
    let layoutManager = NSLayoutManager();
    var oldCharacterTextLayers = Array<CATextLayer>()
    var characterTextLayers = Array<CATextLayer>()
    
    override public var lineBreakMode: NSLineBreakMode {
        get {
            return super.lineBreakMode
        }
        
        set {
            textContainer.lineBreakMode = newValue
            super.lineBreakMode = newValue
        }
        
    }
    
    override public var numberOfLines: Int {
        get {
            return super.numberOfLines
        }
        
        set {
            textContainer.maximumNumberOfLines = newValue
            super.numberOfLines = newValue
        }
        
    }
    
    override public var bounds: CGRect {
        get {
            return super.bounds
        }
        
        set {
            textContainer.size = newValue.size
            super.bounds = newValue
        }
        
    }
    
    override public var text: String! {
        get {
            return super.text
        }
        
        set {
            let wordRange = NSMakeRange(0, newValue.utf16Count)
            var attributedText = NSMutableAttributedString(string: newValue)
            attributedText.addAttribute(NSForegroundColorAttributeName , value:self.textColor, range:wordRange)
            attributedText.addAttribute(NSFontAttributeName , value:self.font, range:wordRange)
            
            var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = self.textAlignment
            attributedText.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range: wordRange)
            self.attributedText = attributedText
        }
        
    }
    
    override public var attributedText: NSAttributedString! {
        get {
            return super.attributedText
        }
        
        set {
            
            if textStorage.string == newValue.string {
                return
            }
            
            cleanOutOldCharacterTextLayers()
            oldCharacterTextLayers = Array<CATextLayer>(characterTextLayers)
            textStorage.setAttributedString(newValue)
        }
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutManager()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayoutManager()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupLayoutManager()
    }
    
    func setupLayoutManager() {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.size = bounds.size
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineBreakMode = lineBreakMode
        layoutManager.delegate = self
    }
    
    func layoutManager(layoutManager: NSLayoutManager!, didCompleteLayoutForTextContainer textContainer: NSTextContainer!, atEnd layoutFinishedFlag: Bool) {
        calculateTextLayers()
    }
    
    func calculateTextLayers() {
        characterTextLayers.removeAll(keepCapacity: false)
            
            let wordRange = NSMakeRange(0, textStorage.string.utf16Count);
            let attributedString = self.internalAttributedText();
            let layoutRect = layoutManager.usedRectForTextContainer(textContainer);
            
            for var index = wordRange.location; index < wordRange.length+wordRange.location; index += 0 {
                let glyphRange = NSMakeRange(index, 1);
                let characterRange = layoutManager.characterRangeForGlyphRange(glyphRange, actualGlyphRange:nil);
                let textContainer = layoutManager.textContainerForGlyphAtIndex(index, effectiveRange: nil);
                var glyphRect = layoutManager.boundingRectForGlyphRange(glyphRange, inTextContainer: textContainer!);
                var location = layoutManager.locationForGlyphAtIndex(index);
                var kerningRange = layoutManager.rangeOfNominallySpacedGlyphsContainingIndex(index);
                
                if kerningRange.length > 1 && kerningRange.location == index {
                    if countElements(characterTextLayers) > 0 {
                        var previousLayer = characterTextLayers[characterTextLayers.endIndex-1]
                        var frame = previousLayer.frame
                        frame.size.width += CGRectGetMaxX(glyphRect)-CGRectGetMaxX(frame)
                        previousLayer.frame = frame
                    }
                }
                
                
                glyphRect.origin.y += location.y-(glyphRect.height/2)+(self.bounds.size.height/2)-(layoutRect.size.height/2);
                
                
                var textLayer = CATextLayer(frame: glyphRect, string: attributedString.attributedSubstringFromRange(characterRange));
                initialTextLayerAttributes(textLayer)
                
                layer.addSublayer(textLayer);
                characterTextLayers.append(textLayer);
                
                index += characterRange.length;
            }
    }
    
    func initialTextLayerAttributes(textLayer: CATextLayer) {
        
    }
    
    func internalAttributedText() -> NSMutableAttributedString! {
        let wordRange = NSMakeRange(0, textStorage.string.utf16Count);
        var attributedText = NSMutableAttributedString(string: textStorage.string);
        attributedText.addAttribute(kCTForegroundColorAttributeName as NSString, value:self.textColor.CGColor, range:wordRange);
        attributedText.addAttribute(kCTFontAttributeName as NSString, value:self.font, range:wordRange);
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        attributedText.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range: wordRange)
        
        return attributedText;
    }
    
    func cleanOutOldCharacterTextLayers() {
        //Remove all text layers from the superview
        for textLayer in oldCharacterTextLayers {
            textLayer.removeFromSuperlayer();
        }
        //clean out the text layer
        oldCharacterTextLayers.removeAll(keepCapacity: false);
    }
}
