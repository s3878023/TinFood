//
//  homeViewModel.swift
//  TinFood
//
//  Created by Đại Đức on 17/09/2023.
//

import SwiftUI
import FirebaseFirestore
import Firebase

class homeViewModel: ObservableObject {
    @Published var fetch_shops: [Shop] = []
    @Published var displaying_shops: [Shop]?
    @Published var likedShops: [Shop] = []

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
    
//    func fetchLikedShops() {
//            // Create a reference to the "Shops" collection in Firestore
//            let shopsRef = db.collection("Shops")
//
//            // Create a query to fetch shops where the shop ID is in the likedShops array
//        shopsRef.whereField(FieldPath.documentID(), in: likedShops).getDocuments { (snapshot, error) in
//                if let error = error {
//                    print("Error fetching liked shops: \(error.localizedDescription)")
//                } else {
//                    if let snapshot = snapshot {
//                        let likedShops = snapshot.documents.compactMap { document in
//                            let data = document.data()
//                            return Shop(
////                                id: document.documentID,
//                                storename: data["storename"] as? String ?? "",
//                                address: data["address"] as? String ?? "",
//                                image: data["image"] as? String ?? ""
//                            )
//                        }
//
//                        // You can now use the `likedShops` array to access the liked shops
//                        print("Liked Shops: \(likedShops)")
//                    }
//                }
//            }
//        }
    func fetchLikedShops() {
        let currentUser = Auth.auth().currentUser
        let userUID = currentUser?.uid
        
        guard let validUserUID = userUID else {
            print("User is not logged in")
            return
        }

        let userRef = db.collection("User").document(validUserUID)

        userRef.getDocument { (snapshot, error) in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
            } else {
                if let data = snapshot?.data(),
                   let likedShopIds = data["likedShops"] as? [String] {
                    // Fetch liked shops based on the shop IDs
                    let likedShopRefs = likedShopIds.map { self.db.collection("Shops").document($0) }
                    self.fetchShops(from: likedShopRefs)
                }
            }
        }
    }

    private func fetchShops(from shopRefs: [DocumentReference]) {
        // Fetch the liked shops from Firestore based on the DocumentReferences
        // You can use a similar approach as in your homeViewModel's fetchShopData
        // to fetch and populate the likedShops array
        // ...

        // Example code for fetching liked shops
        for shopRef in shopRefs {
            shopRef.getDocument { (snapshot, error) in
                if let error = error {
                    print("Error fetching liked shop document: \(error.localizedDescription)")
                } else if let data = snapshot?.data() {
                    // Parse the shop data and add it to the likedShops array
                    let likedShop = Shop(
                        id: snapshot!.documentID,
                        storename: data["storename"] as? String ?? "",
                        address: data["address"] as? String ?? "",
                        image: data["image"] as? String ?? ""
                    )
                    self.likedShops.append(likedShop)
                }
            }
        }
    }
}
