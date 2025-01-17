//
//  Base.swift
//  kNNRealm
//
//  Created by Kawajiri Ryoma on 6/27/15.
//
//

import RealmSwift

public func searchWithResults<T: Object>(q: T, results: Results<T>, k: Int, distance: (l: T, r: T) -> Double) -> [T] {
  var ret = [T]()
  for result in results {
    ret.append(result)
  }

  ret.sort { (a, b) -> Bool in
    return distance(l: q, r: a) < distance(l: q, r: b)
  }

  if ret.count > k {
    ret.removeRange(k..<ret.count)
  }

  return ret
}

public func searchWithRealm<T: Object>(q: T, realm: Realm, k: Int, distance: (l: T, r: T) -> Double) -> [T] {
  return searchWithResults(q, realm.objects(T), k, distance)
}

public func searchWithQuery<T: Object>(q: T, realm: Realm, k: Int, distance: (l: T, r: T) -> Double, query: (q: T, results: Results<T>) -> Results<T>) -> [T] {
  return searchWithResults(q, query(q: q, results: realm.objects(T)), k, distance)
}
