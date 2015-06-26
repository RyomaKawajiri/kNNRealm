//
//  Utils.swift
//  kNNRealm
//
//  Created by Kawajiri Ryoma on 6/26/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import Foundation

internal func deleteRealmFilesAtPath(path: String) {
  let fileManager = NSFileManager.defaultManager()
  fileManager.removeItemAtPath(path, error: nil)
  let lockPath = path + ".lock"
  fileManager.removeItemAtPath(lockPath, error: nil)
}
