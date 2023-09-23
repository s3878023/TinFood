//
//  LikedShopViewModel.swift
//  TinFood
//
//  Created by Nhật Quân on 23/09/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class LikedShopViewModel: ObservableObject {
    @Published var likedShops: [Shop] = []

    private var db = Firestore.firestore()

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
