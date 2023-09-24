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

//    func fetchShopData(completion: @escaping ([Shop]) -> Void) {
//        db.collection("Shops").getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Error fetching data: \(error.localizedDescription)")
//                completion([])
//            } else {
//                if let snapshot = snapshot {
//                    var fetchedShops: [Shop] = []
//                    let group = DispatchGroup()
//
//                    for document in snapshot.documents {
//                        let data = document.data()
//                        let storename = data["storename"] as? String ?? ""
//                        let address = data["address"] as? String ?? ""
//                        let image = data["image"] as? String ?? ""
//
//                        // Fetch the FoodTest subcollection
//                        let foodTestsCollection = document.reference.collection("food")
//                        var foodTests: [FoodTest] = []
//
//                        group.enter()
//
//                        foodTestsCollection.getDocuments { (foodSnapshot, foodError) in
//                            if let foodError = foodError {
//                                print("Error fetching food data: \(foodError.localizedDescription)")
//                            } else if let foodDocuments = foodSnapshot?.documents {
//                                for foodDocument in foodDocuments {
//                                    let foodData = foodDocument.data()
//                                    let foodname = foodData["foodname"] as? String ?? ""
//                                    let price = foodData["price"] as? String ?? ""
//                                    let description = foodData["description"] as? String ?? ""
//                                    let foodImage = foodData["image"] as? String ?? ""
//                                    let category = foodData["category"] as? String ?? ""
//
//                                    let foodTest = FoodTest(
//                                        id: foodDocument.documentID,
//                                        foodname: foodname,
//                                        price: price,
//                                        description: description,
//                                        image: foodImage,
//                                        category: category
//                                    )
//                                    foodTests.append(foodTest)
//                                }
//                            }
//
//                            // Create the Shop object with food data
//                            let shop = Shop(
//                                id: document.documentID,
//                                storename: storename,
//                                address: address,
//                                image: image,
//                                foodTests: foodTests
//                            )
//
//                            // Append the shop to the fetchedShops array
//                            fetchedShops.append(shop)
//
//                            group.leave()
//                        }
//                    }
//
//                    group.notify(queue: .main) {
//                        // All asynchronous operations are complete
//                        completion(fetchedShops)
//                    }
//                }
//            }
//        }
//    }

