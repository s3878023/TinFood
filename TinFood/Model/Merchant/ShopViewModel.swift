//
//  ShopViewModel.swift
//  TinFood
//
//  Created by Nhật Quân on 21/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ShopViewModel: ObservableObject {
    @Published var shoptests = [ShopTest]()

    private var db = Firestore.firestore()

    init() {
        if let currentUser = Auth.auth().currentUser {
            let loggedInUserEmail = currentUser.uid

            // Retrieve shop data for the logged-in user
            db.collection("Shops")
                .whereField(FieldPath.documentID(), isEqualTo: loggedInUserEmail)
                .addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }

                    var shopTests: [ShopTest] = []

                    let group = DispatchGroup() // Create a dispatch group to wait for asynchronous calls

                    for queryDocumentSnapshot in documents {
                        let data = queryDocumentSnapshot.data()
                        let storename = data["storename"] as? String ?? ""
                        let image = data["image"] as? String ?? ""
                        let address = data["address"] as? String ?? ""

                        // Fetch the FoodTest subcollection
                        group.enter() // Enter the dispatch group

                        let foodTestsCollection = queryDocumentSnapshot.reference.collection("Food")
                        var foodTests: [FoodTest] = []

                        foodTestsCollection.getDocuments { (foodQuerySnapshot, foodError) in
                            guard let foodDocuments = foodQuerySnapshot?.documents else {
                                print("No food documents")
                                group.leave() // Leave the dispatch group even if there are no food documents
                                return
                            }

                            for foodDocument in foodDocuments {
                                let foodData = foodDocument.data()
                                let foodname = foodData["foodname"] as? String ?? ""
                                let price = foodData["price"] as? String ?? ""
                                let description = foodData["description"] as? String ?? ""
                                let foodImage = foodData["image"] as? String ?? ""
                                let category = foodData["category"] as? String ?? ""

                                let foodTest = FoodTest(id: foodDocument.documentID, foodname: foodname, price: price, description: description, image: foodImage, category: category)
                                foodTests.append(foodTest)
                            }

                            // Create the ShopTest object with the FoodTest subcollection
                            let shopTest = ShopTest(storename: storename, image: image, address: address, foodTests: foodTests)
                            shopTests.append(shopTest)

                            group.leave() // Leave the dispatch group after fetching food documents
                        }
                    }

                    group.notify(queue: .main) {
                        // All asynchronous operations are complete
                        self.shoptests = shopTests
                    }
                }
        }
    }
    func addFood(newFood: FoodTest) {
        if let currentUser = Auth.auth().currentUser {
            let loggedInUserEmail = currentUser.uid

            // Add the new food item to the "Food" subcollection of the current shop
            db.collection("ActualMerchantTest")
                .whereField(FieldPath.documentID(), isEqualTo: loggedInUserEmail)
                .getDocuments { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }

                    if let shopDocument = documents.first {
                        let shopRef = shopDocument.reference
                        let foodCollectionRef = shopRef.collection("Food")

                        // Convert the newFood object to a dictionary
                        let foodData: [String: Any] = [
                            "foodname": newFood.foodname ?? "",
                            "price": newFood.price ?? "",
                            "description": newFood.description ?? "",
                            "image": newFood.image ?? "",
                            "category": newFood.category ?? ""
                        ]

                        // Add the new food item to the subcollection
                        foodCollectionRef.addDocument(data: foodData) { error in
                            if let error = error {
                                print("Error adding food: \(error.localizedDescription)")
                            } else {
                                print("Food added successfully")
                            }
                        }
                    }
                }
        }
    }
    func deleteFoodItem(foodTest: FoodTest) {
        if let currentUser = Auth.auth().currentUser {
            let loggedInUserEmail = currentUser.uid

            db.collection("ActualMerchantTest")
                .whereField(FieldPath.documentID(), isEqualTo: loggedInUserEmail)
                .getDocuments { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }

                    if let shopDocument = documents.first {
                        let shopRef = shopDocument.reference
                        let foodCollectionRef = shopRef.collection("Food")
                        
                        // Delete the food item from Firestore
                        foodCollectionRef.document(foodTest.id).delete { error in
                            if let error = error {
                                print("Error deleting food: \(error.localizedDescription)")
                            } else {
                                print("Food deleted successfully")
                                
                                // Update the local data by removing the deleted food item
                                if let index = self.shoptests.firstIndex(where: { $0.id == shopDocument.documentID }) {
                                    self.shoptests[index].foodTests = self.shoptests[index].foodTests?.filter { $0.id != foodTest.id }
                                }
                            }
                        }
                    }
                }
        }
    }
}

//class ShopViewModel: ObservableObject{
//    @Published var shoptests = [ShopTest]()
//
//    private var db = Firestore.firestore()
//
//    init(){
//        if let currentUser = Auth.auth().currentUser {
//            let loggedInUserEmail = currentUser.email
//
//            // Retrieve shop data for the logged-in user
//            db.collection("ActualMerchantTest")
//                .whereField("username", isEqualTo: loggedInUserEmail)
//                .addSnapshotListener { (querySnapshot, error) in
//                    guard let documents = querySnapshot?.documents else {
//                        print("No documents")
//                        return
//                    }
//                    // Loop to get the "name" field inside each movie document
//                    self.shoptests = documents.map { (queryDocumentSnapshot) -> ShopTest in
//                        let data = queryDocumentSnapshot.data()
//                        let username = data["username"] as? String ?? ""
//                        let password = data["password"] as? String ?? ""
//                        let storename = data["storename"] as? String ?? ""
//                        let image = data["image"] as? String ?? ""
//                        let address = data["address"] as? String ?? ""
//
//                        return ShopTest(username: username,password: password,storename: storename, image:image,address: address)
//                    }
//                }
//        }
//
//
//    }
//}

//     func getAllShopTestData() {
//         // Retrieve the "movies" document
//         // Lay data ben actual merchant test
//
//        db.collection("ActualMerchantTest").addSnapshotListener { (querySnapshot, error) in
//             guard let documents = querySnapshot?.documents else {
//                 print("No documents")
//                 return
//             }
//             // Loop to get the "name" field inside each movie document
//             self.shoptests = documents.map { (queryDocumentSnapshot) -> ShopTest in
//                 let data = queryDocumentSnapshot.data()
//                 let username = data["username"] as? String ?? ""
//                 let password = data["password"] as? String ?? ""
//                 let storename = data["storename"] as? String ?? ""
//                 let image = data["image"] as? String ?? ""
//                 let address = data["address"] as? String ?? ""
//
//                 return ShopTest(username: username,password: password,storename: storename, image:image,address: address)
//             }
//         }
//     }
