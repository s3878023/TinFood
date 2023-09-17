//
//  Home.swift
//  TinFood
//
//  Created by Đại Đức on 13/09/2023.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData: homeViewModel = homeViewModel()
    var body: some View {
        VStack{
            Button(action: {
                print("Liked Shops: \(homeData.likedShops)")
                        }) {
                            Text("Check Liked Shops")
                        }
            Button(action: {
                print("Liked Shops: \(homeData.dislikedShops)")
                        }) {
                            Text("Check Liked Shops")
                        }
            Button{
                
            } label: {
                Image(systemName: "rectangle.fill.on.rectangle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Text("Discover")
                    .font(.title.bold())
            )
            .foregroundColor(.black)
            .padding()
            
            ZStack{
                if let shops = homeData.displaying_shops{
                    if shops.isEmpty{
                        Text("Please comback later when we can find more shops for you")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    else {
                        ForEach(shops.reversed()){shop in
                            stackCardView(shop: shop)
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
                    
                }label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color(.gray))
                        .clipShape(Circle())
                }
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
                    
                }label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(15)
                        .background(Color("myCyan"))
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
            }
            .padding(.bottom)
            .disabled(homeData.displaying_shops?.isEmpty ?? false)
            .opacity((homeData.displaying_shops?.isEmpty ?? false) ? 0.6 : 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
        Home()
    }
}