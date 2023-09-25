/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tranh Khanh Duc  ID: s3907087
  Created  date: 15/09/2023.
  Last modified: 25/09/2023
  Acknowledgement:
    RMIT Lecture Slides https://rmit.instructure.com/courses/121597
    OpenChatAI: https://chat.openai.com/
    Github: https://github.com/s3878023/TinFood/tree/dev
    SFSymbols
    StackOverFlow: https://stackoverflow.com/
*/


import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class HomeViewModel: ObservableObject {
    @Published var users = [UserModel]()
    @Published var shops = [Shop]()
    @Published var searchText: String = ""
    @Published var index: Int = 1
    @Published var offset = 0
    @Published var showMoreOptions: Bool = false
    @Published var showMoreOptionsMerc: Bool = false
    @Published var selectedUser: UserModel? // Property to store the selected user
    @Published var selectedShop: Shop?
    var db = Firestore.firestore()
    var width = UIScreen.main.bounds.width

    var filteredUsers: [UserModel] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var filteredShops: [Shop] {
        if searchText.isEmpty {
            return shops
        } else {
            return shops.filter { $0.storename.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init() {
        getAllUsersData()
        getAllShopsData()
    }
    
    func getAllUsersData(){
        db.collection("User").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.users = documents.map {(queryDocumentSnapshot) -> UserModel in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                return UserModel(name: name, documentID: queryDocumentSnapshot.documentID)
            }
        }
    }
    func getAllShopsData(){
        db.collection("Shops").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.shops = documents.map {(queryDocumentSnapshot) -> Shop in
                let data = queryDocumentSnapshot.data()
                let name = data["storename"] as? String ?? ""
                let place = data["address"] as? String ?? ""
                let profilePic = data["image"] as? String ?? ""
                return Shop(storename: name, documentID: queryDocumentSnapshot.documentID, address: place, image: profilePic)
            }
        }
    }
    
    func addNewUserData(name: String) {
        // add a new document of a movie name in the "movies" collection
        db.collection("User").addDocument(data: ["name": name])
    }
                                      
    
    func changeView(left: Bool) {

        if left {

            if self.index != 2 {

                self.index += 1
            }
        } else {

            if self.index != 1 {

                self.index -= 1
            }
        }

        if self.index == 1 {

            self.offset = 0
        } else{
            self.offset = Int(-self.width)
        }
    }
    
    func removeUserData(documentID: String){
        db.collection("User").document(documentID).delete{ (error) in
            if let error = error{
                print("Error removing document: \(error)")
            }else{
                print("Document successfully removed")
            }
        }
    }
    func removeShopData(documentID: String){
        db.collection("Shops").document(documentID).delete{ (error) in
            if let error = error{
                print("Error removing document: \(error)")
            }else{
                print("Document successfully removed")
            }
        }
    }
}
