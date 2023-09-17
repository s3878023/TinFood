//
//  FavorRes.swift
//  Tinfood
//
//  Created by Khoa Dang Hoang Anh on 13/09/2023.
//

import SwiftUI

struct FavorRes: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
            NavigationView{
                LazyVGrid(columns: columns, spacing: 30){
                    ForEach(0..<6) { item in
                        NavigationLink ( destination: ResDetailView(),
                                         label: {
                            ContentCell()
                        })
                }
            }
        }
    }
}

struct ContentCell: View {
//    var content : FavorRes
    var body: some View{
            Image("manwah")
                .resizable()
                .scaledToFit()
                .frame(height: 110)
                .padding(.vertical, 4)
                .border(.brown, width: 4)
                .overlay(
                    Text("Manwah")
                        .fontWeight(.semibold)
                        .font(.body)
                        .foregroundColor(Color(hex: 0x383838))
                        .padding(3)
                        .background(Color(hex: 0xf9a35d).opacity(0.7))
//                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .padding(.bottom, 10),
                    alignment: .bottomLeading
                    )
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct FavorRes_Previews: PreviewProvider {
    static var previews: some View {
        FavorRes()
    }
}
