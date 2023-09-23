//
//  LikedShop.swift
//  TinFood
//
//  Created by Nhật Quân on 23/09/2023.
//

import SwiftUI

struct LikedShop: View {
    @ObservedObject var viewModel: LikedShopViewModel

     var body: some View {
         NavigationView {
             List(viewModel.likedShops) { shop in
                 // Display each liked shop as a list item
                 NavigationLink(destination: MerchantViewForUser()) {
                      Text(shop.storename)
                     .font(.system(size: 16))
                 }
             } 
             .navigationBarTitle("Liked Shops")
             .onAppear {
                 viewModel.fetchLikedShops()
             }
         }
     }
}

struct LikedShop_Previews: PreviewProvider {
    static var previews: some View {
        // Initialize a homeViewModel and pass it to LikedShop
        LikedShop(viewModel:LikedShopViewModel())
    }
}
