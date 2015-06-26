//
//  Dog.swift
//  kNNRealm
//
//  Created by Kawajiri Ryoma on 6/26/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import RealmSwift

class Dog: Object {
  dynamic var name = ""
  dynamic var height: Double = 0.0
  dynamic var bodyLength: Double = 0.0
  dynamic var weight: Double = 0.0
}
