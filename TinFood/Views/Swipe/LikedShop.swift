//
//  LikedShop.swift
//  TinFood
//
//  Created by Nhật Quân on 23/09/2023.
//


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

import SwiftUI

struct LikedShop: View {
    @ObservedObject var homeData: homeViewModel
    @State private var searchText = ""
    init(homeData: homeViewModel) {
        self.homeData = homeData
        homeData.fetchLikedShops() // Fetch the liked shops when the view is initialized
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Liked Shops")
                    .font(.title)
                    .padding(.top, 20) // Add padding to create space above the title
                TextField("Search by Store Name", text: $searchText)
                                   .textFieldStyle(RoundedBorderTextFieldStyle())
                                   .padding(.horizontal, 15)
                                   .padding(.bottom, 10)

                ForEach(homeData.likedShops.indices, id: \.self) { index in
                    
                    // Display each liked shop as a list item with fixed size
                    HStack(alignment: .top, spacing: 10) {
                        // Use AsyncImage to load the shop.image asynchronously
                        AsyncImage(url: URL(string: homeData.likedShops[index].image)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(homeData.likedShops[index].storename)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(homeData.likedShops[index].address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)

                        }
                    }
                    .padding(.horizontal, 15)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)

                    // Add spacing between shop items
                    if index != homeData.likedShops.count - 1 {
                        Spacer().frame(height: 20)
                    }
                }
            }
            .padding()
        }
    }
    var filteredLikedShops: [Shop] {
          if searchText.isEmpty {
              return homeData.likedShops
          } else {
              return homeData.likedShops.filter { shop in
                  return shop.storename.localizedCaseInsensitiveContains(searchText)
              }
          }
      }
}

struct LikedShop_Previews: PreviewProvider {
    static var previews: some View {
        // Initialize a homeViewModel and pass it to LikedShop
        LikedShop(homeData: homeViewModel())
    }
}

//struct LikedShop: View {
////    @ObservedObject var viewModel: homeViewModel
//    @ObservedObject var homeData: homeViewModel
//
//    init(homeData: homeViewModel) {
//        self.homeData = homeData
//        homeData.fetchLikedShops() // Fetch the liked shops when the view is initialized
//    }
//
//    var body: some View {
//
//            List(homeData.likedShops) { shop in
//                // Display each liked shop as a list item
//                    Text(shop.storename)
//                        .font(.system(size: 16))
//                Text(shop.address)
//                Text(shop.image)
//            }
//
//    }
//}
//
//struct LikedShop_Previews: PreviewProvider {
//    static var previews: some View {
//        // Initialize a homeViewModel and pass it to LikedShop
//        LikedShop(homeData:homeViewModel())
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
