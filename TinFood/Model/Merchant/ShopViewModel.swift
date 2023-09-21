//
//  ShopViewModel.swift
//  TinFood
//
//  Created by Nhật Quân on 21/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ShopViewModel: ObservableObject{
    @Published var shoptests = [ShopTest]()
    
    private var db = Firestore.firestore()
    
    init(){
        if let currentUser = Auth.auth().currentUser {
            let loggedInUserEmail = currentUser.email
            
            // Retrieve shop data for the logged-in user
            db.collection("ActualMerchantTest")
                .whereField("username", isEqualTo: loggedInUserEmail)
                .addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }
                    // Loop to get the "name" field inside each movie document
                    self.shoptests = documents.map { (queryDocumentSnapshot) -> ShopTest in
                        let data = queryDocumentSnapshot.data()
                        let username = data["username"] as? String ?? ""
                        let password = data["password"] as? String ?? ""
                        let storename = data["storename"] as? String ?? ""
                        let image = data["image"] as? String ?? ""
                        let address = data["address"] as? String ?? ""
                        
                        return ShopTest(username: username,password: password,storename: storename, image:image,address: address)
                    }
                }
        }
        
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
    }
}
