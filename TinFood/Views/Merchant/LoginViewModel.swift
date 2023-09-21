//
//  LoginViewModel.swift
//  TinFood
//
//  Created by An on 9/20/23.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var userUUID: String = ""
    @Published var loginSuccess = false
    @Published var registrationSuccess = false
    @Published var registrationError = ""
    
    init() {
        if UserDefaults.standard.string(forKey: "UUID") != nil{
            self.userUUID = UserDefaults.standard.string(forKey: "UUID")!
        }else{
            self.userUUID = ""
        }
    }
    
    func login(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if let error = error {
                // Fetch error directly from Firebase authentication
                print("Login failed: \(error.localizedDescription)")
            } else if let user = result?.user {
                let uid = user.uid
                print("Login successful! User UID: \(uid)")
                self.loginSuccess = true
                
                // Store the UID in UserDefaults
                UserDefaults.standard.set(uid, forKey: "UUID")
                self.userUUID = uid // Update the @Published property
            }
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
            } else {
                // Registration successful
                if let user = result?.user {
                    let uid = user.uid
                    print("Registration successful! User UID: \(uid)")
                    
                    // Store the UID in UserDefaults or use it as needed
                    UserDefaults.standard.set(uid, forKey: "UUID")
                    
                    // Update the @Published property
                    self.userUUID = uid
                    self.registrationSuccess = false
                }
            }
        }
    }
}

