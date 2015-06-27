//
//  kNNRealmWithQuery.swift
//  kNNRealm
//
//  Created by Kawajiri Ryoma on 5/9/15.
//  Copyright (c) 2015 Kawajiri Ryoma. All rights reserved.
//

import RealmSwift

public class kNNRealmWithQuery<T: Object> {
  public typealias DistanceType = (l: T, r: T) -> Double

  private let k: Int
  private let realm: Realm
  private let distance: (l: T, r: T) -> Double
  private let query: (q: T, results: Results<T>) -> Results<T>

  public init(realm: Realm, k: Int, distance: (l: T, r: T) -> Double, query: (q: T, results: Results<T>) -> Results<T>) {
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
    return searchWithQuery(q, realm, k, distance, query)
  }
}
