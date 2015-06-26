//
//  kNNRealm.swift
//  kNNRealm
//
//  Created by Kawajiri Ryoma on 5/9/15.
//  Copyright (c) 2015 Kawajiri Ryoma. All rights reserved.
//

import RealmSwift

public class kNNRealm<T: Object> {
  private let k: Int
  private let realm: Realm
  private let distance: (l: T, r: T) -> Double
  private let query: (q: T, results: Results<T>) -> Results<T>

  public init(realm: Realm, k: Int, query: (q: T, results: Results<T>) -> Results<T>, distance: (l: T, r: T) -> Double) {
    self.k = k
    self.realm = realm
    self.distance = distance
    self.query = query
  }

  public func add(data: [T]) {
    realm.write {
      self.realm.add(data, update: false)
    }
  }

  public func search(q: T) -> [T] {
    let results = query(q: q, results: realm.objects(T))

    var ret = [T](count: results.count, repeatedValue: T())
    for result in results {
      ret.append(result)
    }

    ret.sorted { (a, b) -> Bool in
      return self.distance(l: q, r: a) > self.distance(l: q, r: b)
    }

    if ret.count > k {
      ret.removeRange(k..<ret.count)
    }

    return ret
  }
}
