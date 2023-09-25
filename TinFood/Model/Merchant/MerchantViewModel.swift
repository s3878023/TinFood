/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tong Nhat Quan  ID: s3819347
  Created  date: 13/09/2023.
  Last modified: 25/09/2023
  Acknowledgement:
    RMIT Lecture Slides https://rmit.instructure.com/courses/121597
    OpenChatAI: https://chat.openai.com/
    Github: https://github.com/s3878023/TinFood/tree/dev
    SFSymbols
    StackOverFlow: https://stackoverflow.com/
*/
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
                let username = data["username"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let storename = data["storename"] as? String ?? ""
                let image = data["image"] as? String ?? ""

                return Merchant(username: username,password: password,storename: storename, image:image)
            }
        }
    }
//    func addNewMerchantData(username,storename,password: String) {
//    // add a new document of a movie name in the "movies" collection
//        db.collection("MerchantTest").addDocument(data: ["username": username,"storename":storename,"password":password])
//    }

    
}
