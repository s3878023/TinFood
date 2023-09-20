//
//  ContentView.swift
//  TinFood
//
//  Created by An on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            if loginViewModel.userUUID == ""{
                LoginView(loginViewModel: loginViewModel)
            }else{
                Home()
            }
            Text("User UUID: \(loginViewModel.userUUID)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

