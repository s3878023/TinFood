//
//  ContentView.swift
//  TinFood
//
//  Created by An on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeData: homeViewModel = homeViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
            if loginViewModel.userUUID == "" || loginViewModel.registrationSuccess == true{
                LoginView(loginViewModel: loginViewModel)
            }else{
                switch UserDefaults.standard.string(forKey: "loginSuccessAs"){
                case "User":
                    Home(homeData: homeData)
                case "Shop":
                    MerchantView()
                case "Admin":
                    SlidingTabView()
                default:
                    Home(homeData: homeData)
                }
            }
//            Text("User UUID: \(loginViewModel.userUUID)")
//        Home(homeData: homeData, loginViewModel: loginViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

