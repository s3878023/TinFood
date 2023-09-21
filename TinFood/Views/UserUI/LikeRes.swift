//
//  LikeRes.swift
//  TinFood
//
//  Created by Bảo Khương Đặng Hoàng on 21/09/2023.
//

import SwiftUI

struct LikeRes: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
//        NavCustomView {
                ZStack{
                    Color("background").ignoresSafeArea()
                    LazyVGrid(columns: columns, spacing: 30){
                        ForEach(0..<6) { item in
                            
                            NavigationLink ( destination: Text("")
//                                .customNavTitle("TinFood")
//                                .customNavSubTitle("Manwah")
                                            ,
                                             label: {
                                ContentCell()
                            })
                    }
                }
            }
//                .CustomNavBarItems(title: "TinFood", subtitle: "Restaurant", backButtonHidden: true)
//        }
        
    }
}

struct ContentCell: View {
//    var content : FavorRes
    var body: some View{
            Image("manwah")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 130)
                .padding(.vertical, 4)
                .border(.brown, width: 4)
                .overlay(
                    Text("Manwah")
                        .fontWeight(.semibold)
                        .font(.body)
                        .foregroundColor(Color("background"))
                        .padding(3)
                        .background(Color("background").opacity(0.7))
//                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .padding(.bottom, 10),
                    alignment: .bottomLeading
                    )
    }
}

struct LikeRes_Previews: PreviewProvider {
    static var previews: some View {
        LikeRes()
    }
}
