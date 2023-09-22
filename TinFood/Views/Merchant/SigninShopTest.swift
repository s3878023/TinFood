//
//  SigninShopTest.swift
//  TinFood
//
//  Created by Nhật Quân on 21/09/2023.
//

import SwiftUI
import Firebase

struct SigninShopTest: View {
    @State var email = ""
    @State var password = ""
    @State var loginSuccess = false

    var body: some View {
        NavigationView { // Wrap the view in a NavigationView
            VStack {
                Group {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                }
                Button {
                    login()
                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(width: 360, height: 50)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                } 
                if loginSuccess {
                    NavigationLink("", destination: MerchantView(), isActive: $loginSuccess)
                        .hidden() // Hide the NavigationLink
                } else {
                    Text("Not Login Successfully Yet! ❌")
                        .foregroundColor(.red)
                }
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                loginSuccess = false
            } else {
                print("success")
                loginSuccess = true
            }
        }
    }
}

struct SigninShopTest_Previews: PreviewProvider {
    static var previews: some View {
        SigninShopTest()
    }
}
