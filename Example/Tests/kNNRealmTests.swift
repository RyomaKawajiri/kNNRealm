//
//  kNNRealmTests.swift
//  kNNRealm
//
//  Created by Kawajiri Ryoma on 6/26/15.
//  Copyright (c) 2015 Kawajiri Ryoma. All rights reserved.
//

import Quick
import Nimble
import kNNRealm
import RealmSwift
import Darwin

class GeneratedDataSetSpec: QuickSpec {

  override func spec() {
    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let realmPath = documentsDirectory[0].stringByAppendingPathComponent("generated_data_set_spec.realm")

    let data: [Dog] = (1...9).map { i in
      let dog = Dog()
      dog.height = Double(i)
      dog.weight = Double(i)
      dog.bodyLength = Double(i)

      switch i {
      case 1...3:
        dog.name = "small"
        break

      case 4...6:
        dog.name = "medium"
        break

      default:
        dog.name = "large"
        break
      }

      return dog
    }

    let k = 3

    let query = { (q: Dog, results: Results<Dog>) -> Results<Dog> in
      return results
        .filter("height >= \(q.height - 2)")
        .filter("height <= \(q.height + 2)")
        .filter("weight >= \(q.weight - 2)")
        .filter("weight <= \(q.weight + 2)")
        .filter("bodyLength >= \(q.bodyLength - 2)")
        .filter("bodyLength <= \(q.bodyLength + 2)")
    }

    let distance = { (l: Dog, r: Dog) -> Double in
      return pow(l.height - r.height, 2) + pow(l.weight - r.weight, 2) + pow(l.bodyLength - r.bodyLength, 2)
    }

    var knn: kNNRealm<Dog>?

    beforeEach {
      // set test data to realm
      deleteRealmFilesAtPath(realmPath)
      knn = kNNRealm<Dog>(realm: Realm(path: realmPath), k: k, query: query, distance: distance)
    }

    afterEach {
      // clear all realm
      deleteRealmFilesAtPath(realmPath)
    }

    describe("basic") {
      describe("add data by kNNRealm") {
        it("can be added data") {
          knn?.add(data)
          expect(Realm(path: realmPath).objects(Dog).count) == data.count
        }

        it("can search correct label") {
          knn?.add(data)

          for dog in data {
            let nearestDogs = knn?.search(dog)
            expect(nearestDogs?.count) == k
          }

          for dog in data {
            let nearestDogs = knn?.search(dog)
            let actual = nearestDogs?.map { dog in Int(dog.height) }
            let i = Int(dog.height)
            switch i {
            case 1:
              expect(actual) == [1, 2, 3]
              break

            case 2...8:
              expect(actual) == [i, i-1, i+1]
              break

            case 9:
              expect(actual) == [9, 8, 7]
              break

            default:
              break
            }
          }
        }
      }

      describe("start from already built realm") {
        beforeEach {
          let realm = Realm(path: realmPath)
          realm.write {
            realm.add(data)
          }
        }

        it ("can search") {
          for dog in data {
            let nearestDogs = knn?.search(dog)
            expect(nearestDogs?.count) == k
          }

          for dog in data {
            let nearestDogs = knn?.search(dog)
            let actual = nearestDogs?.map { dog in Int(dog.height) }
            let i = Int(dog.height)
            switch i {
            case 1:
              expect(actual) == [1, 2, 3]
              break

            case 2...8:
              expect(actual) == [i, i-1, i+1]
              break
              
            case 9:
              expect(actual) == [9, 8, 7]
              break
              
            default:
              break
            }
          }
        }
      }
    }
  }
}
