//
//  NSInitError.swift
//  NSInit
//
//  Created by Sina Rabiei on 6/14/23.
//  Copyright 2023 Sina Rabiei. All rights reserved.
//

import Foundation

enum NSInitError: CustomStringConvertible, Error {
    case onlyApplicableToStructOrClass
    case unableToBuildInit
    
    var description: String {
        switch self {
        case .onlyApplicableToStructOrClass:
            return "@NSInit is only applied to a struct or class."
            
        case .unableToBuildInit:
            return "@NSInit was unable to build the initialzer."
        }
    }
}
