//
//  MerchantViewModel.swift
//  TinFood
//
//  Created by Nhật Quân on 19/09/2023.
//

import Foundation

import FirebaseFirestore

class MerchantViewModel : ObservableObject{
   @Published var merchants = [Merchant]()
    
    private var db = Firestore.firestore()
    
    init(){
       getAllMerchantData()
    }
    
    func getAllMerchantData() {
        // Retrieve the "movies" document
        db.collection("MerchantTest").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            // Loop to get the "name" field inside each movie document
            self.merchants = documents.map { (queryDocumentSnapshot) -> Merchant in
                let data = queryDocumentSnapshot.data()
                let username = data["username"] as? [String] ?? []
                let password = data["password"] as? [String] ?? []
                let storename = data["storename"] as? [String] ?? []
                let image = data["image"] as? [String] ?? []

                return Merchant(username: username,password: password,storename: storename, image:image)
            }
        }
    }
//    func addNewMerchantData(username,storename,password: String) {
//    // add a new document of a movie name in the "movies" collection
//        db.collection("MerchantTest").addDocument(data: ["username": username,"storename":storename,"password":password])
//    }

    
}
