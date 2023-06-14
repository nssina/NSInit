//
//  NSInitTests.swift
//  NSInit
//
//  Created by Sina Rabiei on 6/14/23.
//  Copyright 2023 Sina Rabiei. All rights reserved.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import NSInitMacros

let testMacros: [String: Macro.Type] = [
    "NSInit": NSInitMacro.self
]

final class NSInitTests: XCTestCase {
    func testMacro() {
        assertMacroExpansion(
            """
            @NSInit
            struct Car {
                var number: Int
                var name: String
                var model: String
                var color: String
                var size: Double
            }
            """,
            expandedSource:
            """
            
            struct Car {
                var number: Int
                var name: String
                var model: String
                var color: String
                var size: Double
                init(number: Int, name: String, model: String, color: String, size: Double) {
                    self.number = number
                    self.name = name
                    self.model = model
                    self.color = color
                    self.size = size
                }
            }
            """,
            macros: testMacros)
    }
    
    func testMacroWithClass() {
        assertMacroExpansion(
            """
            @NSInit
            class Car {
                var number: Int
                var name: String
                var model: String
                var color: String
                var size: Double
            }
            """,
            expandedSource:
            """
            
            class Car {
                var number: Int
                var name: String
                var model: String
                var color: String
                var size: Double
                init(number: Int, name: String, model: String, color: String, size: Double) {
                    self.number = number
                    self.name = name
                    self.model = model
                    self.color = color
                    self.size = size
                }
            }
            """,
            macros: testMacros)
    }
    
}
