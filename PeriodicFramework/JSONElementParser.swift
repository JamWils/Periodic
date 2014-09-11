//
//  JSONElementParser.swift
//  Periodic
//
//  Created by James Wilson on 8/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import Foundation

public class JSONElementParser {
    
    public class func loadElementsFromBundle() -> NSData? {
        let bundle = NSBundle(forClass: JSONElementParser.self)//NSBundle.mainBundle().URLForResource("elements", withExtension: "json")
        let url = bundle.URLForResource("elements", withExtension: "json")
        let string = NSString.stringWithContentsOfURL(url!, encoding: NSISOLatin1StringEncoding, error: nil)
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        
        return data
    }
    
    public var elements:[Element] = [Element](count: 118, repeatedValue: Element())
    
    public init(data: NSData) {
        var error = NSError?()

        let json = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.convertFromNilLiteral(), error: &error) as NSDictionary
        
        for (key, value) in json {
            let string = key as String
            let dictionaryValues = value as? Dictionary<String, AnyObject>
            
            if let dictionary = dictionaryValues? {
                let element = Element(elementName: string, dictionary: dictionary)
                self.elements[element.atomicNumber - 1] = element
//                println("\(element.symbol) \(element.atomicNumber)")
            }
            
        }
    }
    
    
}