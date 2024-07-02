//
//  TravelItem.swift
//  TravelList
//
//  Created by chobi on 2024/06/28.
//

import Foundation
import RealmSwift

class TravelItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var isChecked: Bool = false
    @Persisted var item: String = ""
}
