//
//  Testing.swift
//  TinFood
//
//  Created by Nhật Quân on 24/09/2023.
//

import SwiftUI

struct Testing: View {
    @ObservedObject var homeData: homeViewModel
    
    init(homeData: homeViewModel) {
        self.homeData = homeData
        homeData.fetchLikedShops() // Fetch the liked shops when the view is initialized
    }
    
    var body: some View {
        NavigationStack{
            List(homeData.likedShops){ shop in
                VStack{
                    Text(shop.storename)
                    Text(shop.address)
                }
            }
        }
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing(homeData:homeViewModel())
    }
}

//                    AsyncImage(url: URL(string: shop.image ?? "")) { phase in
//                        switch phase {
//                        case .empty:
//                            // Placeholder or loading view if needed
//                            Text("Loading...")
//                        case .success(let image):
//                            image
//                                .resizable() // Make the image resizable
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width:90)
//                        case .failure:
//                            // Handle error if image fails to load
//                            Text("Image loading failed")
//                        @unknown default:
//                            // Handle unknown cases or provide a fallback view
//                            Text("Unknown state")
//                        }
//                    }
//                    .frame(width: 100, height: 100)
