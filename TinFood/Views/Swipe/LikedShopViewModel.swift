/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Duc Dai  ID: s3878023
  Created  date: 15/09/2023.
  Last modified: 25/09/2023
  Acknowledgement:
    RMIT Lecture Slides https://rmit.instructure.com/courses/121597
    OpenChatAI: https://chat.openai.com/
    Github: https://github.com/s3878023/TinFood/tree/dev
    SFSymbols
    StackOverFlow: https://stackoverflow.com/
*/

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
