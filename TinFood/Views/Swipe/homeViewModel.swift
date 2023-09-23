//
//  homeViewModel.swift
//  TinFood
//
//  Created by Đại Đức on 17/09/2023.
//
//
//import SwiftUI
//
//class homeViewModel: ObservableObject {
//    @Published var fetch_shops: [Shop] = []
//    @Published var displaying_shops: [Shop]?
//    @Published var likedShops: [String] = []
//    @Published var dislikedShops: [String] = []
//
//
//    init(){
//        fetch_shops = [
//            Shop(id: "1",name: "Burger1", place: "HCM", profilePic: "1"),
//            Shop(id: "2",name: "Burger2", place: "HCM", profilePic: "2"),
//            Shop(id: "3",name: "Burger3", place: "HCM", profilePic: "3"),
//            Shop(id: "4",name: "Burger4", place: "HCM", profilePic: "4"),
//            Shop(id: "5",name: "Burger5", place: "HCM", profilePic: "5"),
//            Shop(id: "6",name: "Burger6", place: "HCM", profilePic: "6")
//        ]
//        displaying_shops = fetch_shops
//    }
//    func getIndex(shop: Shop) -> Int{
//        let index = displaying_shops?.firstIndex(where: {currentShop in
//            return shop.id == currentShop.id
//        })  ?? 0
//        return index
//    }
//}
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
                        let id = document.documentID
                        return Shop(
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
