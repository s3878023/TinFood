//
//  ShopTestView.swift
//  TinFood
//
//  Created by Nhật Quân on 21/09/2023.
//

import SwiftUI

struct ShopTestView: View {
    @StateObject private var shopViewModel = ShopViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                VStack{
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
                ForEach(shopViewModel.shoptests, id: \.id) { merchant in
                    VStack{
                        AsyncImage(url: URL(string: merchant.image ?? "")) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder or loading view if needed
                                Text("Loading...")
                            case .success(let image):
                                image
                                    .resizable() // Make the image resizable
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:90)
                            case .failure:
                                // Handle error if image fails to load
                                Text("Image loading failed")
                            @unknown default:
                                // Handle unknown cases or provide a fallback view
                                Text("Unknown state")
                            }
                        }
                        .frame(width: 100, height: 100)
                        VStack(alignment: .leading){
                            Text(merchant.storename ?? "")
                                .font(.system(size:20))
                            Text(merchant.address ?? "")
                                .font(.system(size:12))
                        }
                        Spacer()
                        VStack(alignment: .trailing){
                            Text(merchant.image ?? "")
                                .fontWeight(.bold)
                                .font(.system(size:20))
                            Text(merchant.username ?? "")
                                .font(.system(size:12))
                        }
                    }
                    .frame(height : 80)
                    .frame(maxWidth: 350)
                    Divider()
                     .frame(height: 1)
                     .background(Color("components"))
                     .frame(maxWidth: 350)
                  
                    
                }

            }
            .ignoresSafeArea(.all)
    
        }
        
    }
}

struct ShopTestView_Previews: PreviewProvider {
    static var previews: some View {
        ShopTestView()
    }
}
