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
