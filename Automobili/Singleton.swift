//
//  Singleton.swift
//  Automobili
//
//  Created by Stefan Djordjevic on 3/27/17.
//  Copyright © 2017 Stefan Djordjevic. All rights reserved.
//

import Foundation


class MySingleton {
    
    static let sharedInstance = MySingleton()
    
    var  car = [Car]()
    var ucitanoCar = false
    var ucitnoGuma = false
    var slikeKola = [UIImage]()
    var slikeGuma = [UIImage]()
    var maxCar = Int()
    var maxGume = Int()
    var gume = [Gume]()
    private init () {}
   
}
