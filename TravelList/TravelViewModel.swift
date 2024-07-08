//
//  TravelViewModel.swift
//  TravelList
//
//  Created by chobi on 2024/06/28.
//

import Foundation
import RealmSwift

class TravelViewModel: ObservableObject {
    private var realm: Realm
    @Published var travelLists: [TravelItem] = []

    init() {
        do {
            realm = try Realm()
            checkAndAddInitialData()
            loadTravelItems()
        } catch {
            print("Realmの初期化に失敗しました。 Error: \(error.localizedDescription)")
            realm = try! Realm(configuration: .init(inMemoryIdentifier: "TemporaryRealm"))
        }
    }
    
    func checkAndAddInitialData() {
        let items = realm.objects(TravelItem.self)
        if items.isEmpty {
            let initialItems = [
            TravelItem(value: ["isChecked": false, "item": "着替え"]),
            TravelItem(value: ["isChecked": false, "item": "充電器"]),
            TravelItem(value: ["isChecked": false, "item": "タオル"]),
            TravelItem(value: ["isChecked": false, "item": "アイマスク"])
            ]
            do {
                try realm.write {
                    realm.add(initialItems)
                }
            } catch {
                print("TravelItem初期値の設定に失敗しました。 Error: \(error.localizedDescription)")
            }
        }
    }
    

    func loadTravelItems() {
        let items = realm.objects(TravelItem.self)  //Results<TravelItem>型になる
        travelLists = Array(items)
    }
    

    func addTravelItem(title: String) {
        let newItem = TravelItem()
        newItem.item = title

        do {
            try realm.write {
                realm.add(newItem)
            }
            loadTravelItems()
        } catch {
            print("TravelItemの追加に失敗しました。 Error: \(error.localizedDescription)")
        }
    }

 /*   func deleteTravelItems(at offsets: IndexSet) {
        offsets.map { travelLists[$0] }.forEach { item in
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("TravelItemのリストからの削除に失敗しました。 Error: \(error.localizedDescription)")
            }
        }
        loadTravelItems()
    } */
    
    func deleteTravelItems(at offsets: IndexSet) {
        let itemToDelete = offsets.map { travelLists[$0] }
        do {
            try realm.write {
                realm.delete(itemToDelete)
            }
        } catch {
            print("TravelItemのリストからの削除に失敗しました。 Error: \(error.localizedDescription)")
        }
        loadTravelItems()
    }

    func clearCheckboxes() {
        do {
            try realm.write {
                for item in travelLists {
                    item.isChecked = false
                }
            }
            loadTravelItems()
        } catch {
            print("チェックボックスのクリアに失敗しました。 Error: \(error.localizedDescription)")
        }
    }

    func toggleCheck(for item: TravelItem) {
        do {
            try realm.write {
                item.isChecked.toggle()
            }
            loadTravelItems()
        } catch {
            print("チェックボックスの切り替え(トグル)に失敗しました。 Error: \(error.localizedDescription)")
        }
    }
}



