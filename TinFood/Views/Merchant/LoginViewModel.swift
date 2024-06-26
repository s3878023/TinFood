/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quoc An  ID: s3938278
  Created  date: 13/09/2023.
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

class LoginViewModel: ObservableObject {
    @Published var userUUID: String = ""
    @Published var loginSuccess = false
    @Published var registrationSuccess = false
    @Published var registrationError = ""
    @Published var showRegisterAlert = false
    @Published var loginSuccessAs = ""
    
    private var db = Firestore.firestore()
    

    
    init() {
        if UserDefaults.standard.string(forKey: "UUID") != nil{
            self.userUUID = UserDefaults.standard.string(forKey: "UUID")!
        }else{
            self.userUUID = ""
        }
    }
    
//    func login(username: String, password: String, role: String) {
//        Auth.auth().signIn(withEmail: username, password: password) { [self] (result, error) in
//            if let error = error {
//                // Fetch error directly from Firebase authentication
//                print("Login failed: \(error.localizedDescription)")
//            } else if let user = result?.user {
//                let uid = user.uid
//                print("Login successful! User UID: \(uid)")
//                self.loginSuccess = true
//
//                // Store the UID in UserDefaults
//                UserDefaults.standard.set(uid, forKey: "UUID")
//                self.userUUID = uid // Update the @Published property
//            }
//        }
//    }
    
    func login(username: String, password: String, role: String) {
        
        switch role{
        case "User":
            Auth.auth().signIn(withEmail: username, password: password) { [self] (result, error) in
                if let error = error {
                    // Fetch error directly from Firebase authentication
                    print("Login failed: \(error.localizedDescription)")
                } else if let user = result?.user {
                    let uid = user.uid

                    fetchAllDocumentIDsFromUserCollection(collectionName: "User") { documentIDs in
                        print(documentIDs)
                        if documentIDs.contains(uid){
                            self.loginSuccess = true
                            // Store the UID in UserDefaults
                            UserDefaults.standard.set(uid, forKey: "UUID")
                            // Update the @Published property
                            self.userUUID = uid
                            self.loginSuccessAs = "User"
                            UserDefaults.standard.set("User", forKey: "loginSuccessAs")
                            print("Login successful as User ! User UID: \(uid)")
                        }
                    }

                }
            }
            self.loginSuccess = false
            break
            
        case "Shop":
            Auth.auth().signIn(withEmail: username, password: password) { [self] (result, error) in
                if let error = error {
                    // Fetch error directly from Firebase authentication
                    print("Login failed: \(error.localizedDescription)")
                } else if let user = result?.user {
                    let uid = user.uid

                    fetchAllDocumentIDsFromUserCollection(collectionName: "ActualMerchantTest") { documentIDs in
                        print(documentIDs)
                        if documentIDs.contains(uid){
                            self.loginSuccess = true
                            // Store the UID in UserDefaults
                            UserDefaults.standard.set(uid, forKey: "UUID")
                            // Update the @Published property
                            self.userUUID = uid
                            self.loginSuccessAs = "Shop"
                            UserDefaults.standard.set("Shop", forKey: "loginSuccessAs")
                            print("Login successful as Shop! Shop UID: \(uid)")
                        }
                    }

                }
            }
            self.loginSuccess = false
            break
            
        case "Admin":
            Auth.auth().signIn(withEmail: username, password: password) { [self] (result, error) in
                if let error = error {
                    // Fetch error directly from Firebase authentication
                    print("Login failed: \(error.localizedDescription)")
                } else if let user = result?.user {
                    let uid = user.uid

                    fetchAllDocumentIDsFromUserCollection(collectionName: "Admin") { documentIDs in
                        print(documentIDs)
                        if documentIDs.contains(uid){
                            self.loginSuccess = true
                            // Store the UID in UserDefaults
                            UserDefaults.standard.set(uid, forKey: "UUID")
                            // Update the @Published property
                            self.userUUID = uid
                            self.loginSuccessAs = "Admin"
                            UserDefaults.standard.set("Admin", forKey: "loginSuccessAs")
                            print("Login successful as Shop! Shop UID: \(uid)")
                        }
                    }

                }
            }
            self.loginSuccess = false
            break
            
        default:
            return
        }
    }
    
    func register(username: String, password: String, profileImageUrlString: String) {
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            if let error = error {
                // Fetch error directly from Firebase authentication
                print("Registration failed: \(error.localizedDescription)")
                self.registrationError = error.localizedDescription
                print(self.registrationError)
                self.registrationSuccess = false
                self.showRegisterAlert = true
            } else {
                // Registration successful
                if let user = result?.user {
                    let uid = user.uid
                    print("Registration successful! User UID: \(uid)")
                    //Register to data
                    // Store the UID in UserDefaults or use it as needed
                    UserDefaults.standard.set(uid, forKey: "UUID")
                    
                    // Update the @Published property
                    self.userUUID = uid
                    self.registrationSuccess = true
                    self.registerNewUserDataIntoFirebase(name: username, profileImageUrlString: profileImageUrlString)
                    self.showRegisterAlert = true
                }
            }
        }
        
    }
    
    func registerNewUserDataIntoFirebase(name: String, profileImageUrlString: String) {
        let documentID = self.userUUID

        let collectionName = "User"
        
        let db = Firestore.firestore()
        
        db.collection(collectionName).document(documentID).setData([
            "name": name,
            "profilePicture": profileImageUrlString,
            "likedShops": [String](),
            "likedCategory": [String](),
            "blockedShops": [String]()
            
        ]) { error in
            if let error = error {
                print("Error updating Firestore: \(error.localizedDescription)")
            } else {
                print("Registered successfully")
            }
        }
    }
    
    func registerShop(username: String, password: String, profileImageUrlString: String, restaurantName: String, address: String) {
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            if let error = error {
                // Fetch error directly from Firebase authentication
                print("Registration failed: \(error.localizedDescription)")
                self.registrationError = error.localizedDescription
                print(self.registrationError)
                self.registrationSuccess = false
                self.showRegisterAlert = true
            } else {
                // Registration successful
                if let user = result?.user {
                    let uid = user.uid
                    print("Registration successful! User UID: \(uid)")
                    //Register to data
                    // Store the UID in UserDefaults or use it as needed
                    UserDefaults.standard.set(uid, forKey: "UUID")
                    
                    // Update the @Published property
                    self.userUUID = uid
                    self.registrationSuccess = true
                    self.registerNewShopDataIntoFirebase(name: restaurantName, address: address, profileImageUrlString: profileImageUrlString)
                    self.showRegisterAlert = true
                }
            }
        }
        
    }
    
    func registerNewShopDataIntoFirebase(name: String, address: String, profileImageUrlString: String) {
        let documentID = self.userUUID
        let collectionName = "Shops"
        let subcollectionName = "food"

        let db = Firestore.firestore()

        // Reference to the shop document
        let shopReference = db.collection(collectionName).document(documentID)

        // Structure of "food" document
        let foodDocument: [String: Any] = [
            "category": "",   // String
            "description": "",   // String
            "foodName": "",   // String
            "image": "",   // String
            "price": ""   // String
        ]

        // Add "food" documents to the subcollection of Shops collection
        let foodCollectionReference = shopReference.collection(subcollectionName)

        foodCollectionReference.addDocument(data: foodDocument) { error in
            if let error = error {
                print("Error adding document to subcollection: \(error.localizedDescription)")
            } else {
                print("Document added to subcollection successfully")
            }
        }

        // Update the shop document with other data
        shopReference.setData([
            "storename": name,
            "image": profileImageUrlString,
            "address": address
        ]) { error in
            if let error = error {
                print("Error updating Firestore: \(error.localizedDescription)")
            } else {
                print("Registered successfully")
            }
        }
    }

    
    func userExistsWithUUIDAndRole(uuid: String, role: String, completion: @escaping (Bool) -> Void) {
        
    }
        
    func fetchAllDocumentIDsFromUserCollection(collectionName: String, completion: @escaping ([String]) -> Void) {
        let userCollectionRef = db.collection(collectionName)
        
        userCollectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([]) // Return an empty array in case of an error
            } else {
                // Use map to extract document IDs from the documents
                let documentIDs = querySnapshot?.documents.map { $0.documentID } ?? []
                
                completion(documentIDs)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            
            // Clear the UserDefaults values
            UserDefaults.standard.removeObject(forKey: "UUID")
            UserDefaults.standard.removeObject(forKey: "loginSuccessAs")
            
            self.loginSuccess = false
            self.userUUID = ""
            self.loginSuccessAs = ""
            
            LoginView(loginViewModel: LoginViewModel())
            
            print("Logout successful")
        } catch let error as NSError {
            print("Error signing out: \(error.localizedDescription)")
        }
    }



}


