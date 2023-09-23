//
//  LoginViewModel.swift
//  TinFood
//
//  Created by An on 9/20/23.
//

import SwiftUI
import Firebase

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
    
    func register(username: String, password: String) {
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
                    self.registerNewUserDataIntoFirebase(name: username)
                    self.showRegisterAlert = true
                }
            }
        }
        
    }
    
    func registerNewUserDataIntoFirebase(name: String) {
        let documentID = self.userUUID

        let collectionName = "User"
        
        let db = Firestore.firestore()
        
        db.collection(collectionName).document(documentID).setData([
            "name": name,
            "profilePicture": "https://firebasestorage.googleapis.com/v0/b/tinfood-17312.appspot.com/o/avatar.png?alt=media&token=c644573a-9f61-4dd5-a050-1130233a9143",
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
    
    func registerNewShopDataIntoFirebase(){}
    
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



}


