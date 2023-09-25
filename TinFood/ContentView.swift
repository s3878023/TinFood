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

struct ContentView: View {
    @StateObject var homeData: homeViewModel = homeViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
            if loginViewModel.userUUID == "" || loginViewModel.registrationSuccess == true{
                LoginView(loginViewModel: loginViewModel)
            }else{
                switch UserDefaults.standard.string(forKey: "loginSuccessAs"){
                case "User":
                    Home(homeData: homeData, loginViewModel: loginViewModel)
                case "Shop":
                    MerchantView(loginViewModel: loginViewModel)
                case "Admin":
                    SlidingTabView(loginViewModel: loginViewModel)
                default:
                    Home(homeData: homeData, loginViewModel: loginViewModel)
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

