/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Duc Dai  ID: s3878023
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

struct Home: View {
    @ObservedObject var homeData: homeViewModel = homeViewModel()
//    @ObservedObject var loginViewModel: LoginViewModel
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color("background"))
                VStack{
                    HStack {
                        Button(action: {
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(Color("swipe"))
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Discover")
                            .font(.title.bold())
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color("swipe"))
                        
                    
                        Button{
                        }label: {
                            Image(systemName: "power.circle.fill")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        .foregroundColor(Color("swipe"))
                    }
                    ZStack{
                        if let shops = homeData.displaying_shops{
                            if shops.isEmpty{
                                Text("Please comback later when we can find more shops for you")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            else {
                                ForEach(shops.reversed()){shop in
                                    stackCardView(loginViewModel: LoginViewModel(), shop: shop)
                                        .environmentObject(homeData)
                                }
                            }
                        }
                        else{
                            ProgressView()
                        }
                    }
                    .padding(.top, 30)
                    .padding()
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    HStack(spacing: 15){
                        Button{
                            doSwipe()
                        }label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .padding(15)
                                .background(Color("myRed"))
                                .clipShape(Circle())
                        }

                        Button{
                            doSwipe(rightSwipe: true)
                        }label: {
                            Image(systemName: "suit.heart.fill")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .padding(15)
                                .background(Color("myGreen"))
                                .clipShape(Circle())
                        }
                        NavigationLink(destination: LikedShop(homeData: homeViewModel())) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(radius: 5)  
                                .padding(15)
                                .background(Color("myYell"))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.bottom)
//                    .disabled(homeData.displaying_shops?.isEmpty ?? false)
                    .opacity((homeData.displaying_shops?.isEmpty ?? false) ? 0.6 : 1)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .preferredColorScheme(isDarkMode ? .light : .dark)

            }
        }
        
    }
    func doSwipe(rightSwipe: Bool = false){
        guard let first = homeData.displaying_shops?.first else {
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id" : first.id,
            "rightSwipe" : rightSwipe
        ])
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(homeData: homeViewModel(), isDarkMode: false)
    }
}
