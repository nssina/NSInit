//
//  main.swift
//  NSInit
//
//  Created by Sina Rabiei on 6/14/23.
//  Copyright 2023 Sina Rabiei. All rights reserved.
//

import NSInit
import CoreLocation

@NSInit
public class Car {
    var number: Int
    var name: String
    var model: String
    var color: String
    var size: Double
}

@NSInit
struct City {
    var name: String
    var population: Int
    var country: String
    var location: CLLocation
}
