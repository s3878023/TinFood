//
//  LikedShop.swift
//  TinFood
//
//  Created by Nhật Quân on 23/09/2023.
//

import SwiftUI

//struct LikedShop: View {
//    @ObservedObject var viewModel: homeViewModel
//
//     var body: some View {
//         NavigationView {
//             List(viewModel.likedShops) { shop in
//                 // Display each liked shop as a list item
//                 NavigationLink(destination: MerchantViewForUser()) {
//                      Text(shop.storename)
//                     .font(.system(size: 16))
//                 }
//             }
//             .navigationBarTitle("Liked Shops")
//             .onAppear {
//                 viewModel.fetchLikedShops()
//             }
//         }
//     }
//}

struct LikedShop: View {
//    @ObservedObject var viewModel: homeViewModel
    @ObservedObject var homeData: homeViewModel
    init(homeData: homeViewModel) {
        self.homeData = homeData
        homeData.fetchLikedShops() // Fetch the liked shops when the view is initialized
    }

    var body: some View {
        NavigationView {
            List(homeData.likedShops) { shop in
                // Display each liked shop as a list item
                NavigationLink(destination: Testing()
                ) {
                    Text(shop.storename)
                        .font(.system(size: 16))
                }
            }
            .navigationBarTitle("Liked Shops")
        }
    }
}

struct LikedShop_Previews: PreviewProvider {
    static var previews: some View {
        // Initialize a homeViewModel and pass it to LikedShop
        LikedShop(homeData:homeViewModel())
    }
}



//import SwiftUI
//
//struct LikedShop: View {
//    @ObservedObject var viewModel: homeViewModel
//    @State private var filteredShops: [Shop] = []
//
//    var body: some View {
//        NavigationView {
//            List(filteredShops) { shop in
//                // Display each liked shop as a list item
//                NavigationLink(destination: MerchantViewForUser()) {
//                    Text(shop.storename)
//                        .font(.system(size: 16))
//                }
//            }
//            .navigationBarTitle("Liked Shops")
//            .onAppear {
//                filterShops()
//            }
//        }
//    }
//
//    func filterShops() {
//        // Get the unique store IDs from the liked shops
//        let uniqueStoreIDs = Set(viewModel.likedShops.map { $0.id })
//
//        // Filter out shops that have IDs not in the uniqueStoreIDs set
//        filteredShops = viewModel.likedShops.filter { uniqueStoreIDs.contains($0.id) }
//    }
//}
//
//struct LikedShop_Previews: PreviewProvider {
//    static var previews: some View {
//        // Initialize a homeViewModel and pass it to LikedShop
//        LikedShop(viewModel: homeViewModel())
//    }
//}



//import SwiftUI
//
//struct LikedShop: View {
//    @ObservedObject var viewModel: homeViewModel
//    @State private var filteredShops: [Shop] = []
//
//    var body: some View {
//        NavigationView {
//            List(filteredShops) { shop in
//                // Display each liked shop as a list item
//                NavigationLink(destination: MerchantViewForUser()) {
//                    Text(shop.storename)
//                        .font(.system(size: 16))
//                }
//            }
//            .navigationBarTitle("Liked Shops")
//            .onAppear {
//                filterShops()
//            }
//        }
//    }
//
//    func filterShops() {
//        // Create a set to keep track of unique store IDs
//        var uniqueStoreIDs: Set<String> = []
//
//        // Create an array to hold the filtered shops
//        var filteredShops: [Shop] = []
//
//        for shop in viewModel.likedShops {
//            if !uniqueStoreIDs.contains(shop.id) {
//                // If the store ID is not in the set, it's unique, so add it to the filtered shops
//                uniqueStoreIDs.insert(shop.id)
//                filteredShops.append(shop)
//            }
//        }
//
//        // Update the @State variable with the filtered shops
//        self.filteredShops = filteredShops
//    }
//}
//
//struct LikedShop_Previews: PreviewProvider {
//    static var previews: some View {
//        // Initialize a homeViewModel and pass it to LikedShop
//        LikedShop(viewModel: homeViewModel())
//    }
//}
