//
//  RealmTicker.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 18.01.2022.
//

import Foundation
import RealmSwift
import Realm

class RealmTicker: RealmSwiftObject {
    @Persisted(primaryKey: true) var id: String
    @Persisted var base: String
    @Persisted var target: String
    @Persisted var price: String
    @Persisted var volume: String
    @Persisted var change: String
}
