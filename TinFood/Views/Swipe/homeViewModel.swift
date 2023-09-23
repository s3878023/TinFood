//
//  homeViewModel.swift
//  TinFood
//
//  Created by Đại Đức on 17/09/2023.
//

import SwiftUI
import FirebaseFirestore

class homeViewModel: ObservableObject {
    @Published var fetch_shops: [Shop] = []
    @Published var displaying_shops: [Shop]?
    @Published var likedShops: [String] = []
    @Published var dislikedShops: [String] = []

    private var db = Firestore.firestore()

    init() {
        fetchShopData() // Fetch shop data from Firestore
    }

    func fetchShopData() {
        db.collection("Shops").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            } else {
                if let snapshot = snapshot {
                    self.fetch_shops = snapshot.documents.compactMap { document in
                        let data = document.data()
                        _ = document.documentID
                        return Shop(
                            id : document.documentID,
//                            id: data["id"] as? String ?? "",
                            storename: data["storename"] as? String ?? "",
                            address: data["address"] as? String ?? "",
                            image: data["image"] as? String ?? ""
                        )
                    }
                    self.displaying_shops = self.fetch_shops
                }
            }
        }
    }

    func getIndex(shop: Shop) -> Int {
        let index = displaying_shops?.firstIndex { currentShop in
            return shop.id == currentShop.id
        } ?? 0
        return index
    }
}
