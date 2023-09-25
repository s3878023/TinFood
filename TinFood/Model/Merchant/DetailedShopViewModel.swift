//
//  DetailedShopViewModel.swift
//  TinFood
//
//  Created by Nhật Quân on 24/09/2023.
//

//import Foundation
//import FirebaseFirestore
//
//class DetailedShopViewModel: ObservableObject{
//    @Published var shoptests = [ShopTest]()
//
//    private var db = Firestore.firestore()
//
//
//    func fetchData(){
//        db.collection("Shops")
////            .whereField(FieldPath.documentID(), isEqualTo: loggedInUserEmail)
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents")
//                    return
//                }
//
//                var shopTests: [ShopTest] = []
//
//                let group = DispatchGroup() // Create a dispatch group to wait for asynchronous calls
//
//                for queryDocumentSnapshot in documents {
//                    let data = queryDocumentSnapshot.data()
//                    let storename = data["storename"] as? String ?? ""
//                    let image = data["image"] as? String ?? ""
//                    let address = data["address"] as? String ?? ""
//
//                    // Fetch the FoodTest subcollection
//                    group.enter() // Enter the dispatch group
//
//                    let foodTestsCollection = queryDocumentSnapshot.reference.collection("food")
//                    var foodTests: [FoodTest] = []
//
//                    foodTestsCollection.getDocuments { (foodQuerySnapshot, foodError) in
//                        guard let foodDocuments = foodQuerySnapshot?.documents else {
//                            print("No food documents")
//                            group.leave() // Leave the dispatch group even if there are no food documents
//                            return
//                        }
//
//                        for foodDocument in foodDocuments {
//                            let foodData = foodDocument.data()
//                            let foodname = foodData["foodname"] as? String ?? ""
//                            let price = foodData["price"] as? String ?? ""
//                            let description = foodData["description"] as? String ?? ""
//                            let foodImage = foodData["image"] as? String ?? ""
//                            let category = foodData["category"] as? String ?? ""
//
//                            let foodTest = FoodTest(id: foodDocument.documentID, foodname: foodname, price: price, description: description, image: foodImage, category: category)
//                            foodTests.append(foodTest)
//                        }
//
//                        // Create the ShopTest object with the FoodTest subcollection
//                        let shopTest = ShopTest(storename: storename, image: image, address: address, foodTests: foodTests)
//                        shopTests.append(shopTest)
//
//                        group.leave() // Leave the dispatch group after fetching food documents
//                    }
//                }
//
//                group.notify(queue: .main) {
//                    // All asynchronous operations are complete
//                    self.shoptests = shopTests
//                }
//            }
//    }
//}

import Foundation
import FirebaseFirestore
 
class DetailedShopViewModel: ObservableObject {
     
    @Published var testinggs = [Testingg]()
     
    private var db = Firestore.firestore()
     
    func fetchData() {
        db.collection("Testing").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
             
            self.testinggs = documents.map { (queryDocumentSnapshot) -> Testingg in
                let data = queryDocumentSnapshot.data()
                let storename = data["storename"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                return Testingg(storename: storename, address: address, image: image)
            }
        }
    }
}
