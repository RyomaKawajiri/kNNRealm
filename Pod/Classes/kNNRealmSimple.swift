//
//  kNNRealmSimple.swift
//  Pods
//
//  Created by Kawajiri Ryoma on 6/27/15.
//
//

import RealmSwift

public class kNNRealmSimple<T: Object> {
  public typealias DistanceType = (l: T, r: T) -> Double

  private let k: Int
  private let realm: Realm
  private let distance: (l: T, r: T) -> Double

  public init(realm: Realm, k: Int, distance: (l: T, r: T) -> Double) {
    self.k = k
    self.realm = realm
    self.distance = distance
  }

  public func add(data: [T]) {
    realm.write {
      self.realm.add(data, update: false)
    }
  }

  public func search(q: T) -> [T] {
    return searchWithRealm(q, realm, k, distance)
  }
}
