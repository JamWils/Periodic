//
//  Element.swift
//  Periodic
//
//  Created by James Wilson on 8/29/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

import Foundation

public class Element {
    
    public init () {
        self.symbol = ""
        self.atomicNumber = 0
        self.name = ""
    }
    
    public init (elementName: String, dictionary: NSDictionary) {
        self.symbol = dictionary["symbol"] as String
        self.atomicNumber = dictionary["atomic_number"] as Int
        self.name = elementName
    }
    
    public let symbol:String
    public let atomicNumber : Int
    public let name:String
}