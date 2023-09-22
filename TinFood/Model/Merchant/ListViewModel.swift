//
//  ListViewModel.swift
//  TinFood
//
//  Created by Nhật Quân on 22/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ListViewModel: ObservableObject{
    @Published var shoptests = [ShopTest]()

    private var db = Firestore.firestore()
    
    init() {
        if let currentUser = Auth.auth().currentUser {
            let loggedInUserEmail = currentUser.email

            // Retrieve shop data for the logged-in user
            db.collection("ActualMerchantTest")
                .addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }

                    var shopTests: [ShopTest] = []

                    let group = DispatchGroup() // Create a dispatch group to wait for asynchronous calls

                    for queryDocumentSnapshot in documents {
                        let data = queryDocumentSnapshot.data()
                        let username = data["username"] as? String ?? ""
                        let password = data["password"] as? String ?? ""
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
                            let shopTest = ShopTest(username: username, password: password, storename: storename, image: image, address: address, foodTests: foodTests)
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
}
