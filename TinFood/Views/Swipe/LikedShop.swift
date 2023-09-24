//
//  LikedShop.swift
//  TinFood
//
//  Created by Nhật Quân on 23/09/2023.
//


//
//import SwiftUI
//struct LikedShop: View {
//    @ObservedObject var homeData: homeViewModel
//    @State private var searchText = ""
//
//    init(homeData: homeViewModel) {
//        self.homeData = homeData
//        homeData.fetchLikedShops() // Fetch the liked shops when the view is initialized
//    }
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                Text("Liked Shops")
//                    .font(.title)
//                    .padding(.top, 20) // Add padding to create space above the title
//                TextField("Search by Store Name", text: $searchText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal, 15)
//                    .padding(.bottom, 10)
//
//                ForEach(filteredLikedShops.indices, id: \.self) { index in
//                    // Use filteredLikedShops instead of homeData.likedShops
//                    let shop = filteredLikedShops[index]
//
//                    // Display each liked shop as a list item with fixed size
//                    HStack(alignment: .top, spacing: 10) {
//                        // Use AsyncImage to load the shop.image asynchronously
//                        AsyncImage(url: URL(string: shop.image)) { image in
//                            image.resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 100, height: 100)
//                                .cornerRadius(15)
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(width: 100, height: 100)
//
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text(shop.storename)
//                                .font(.system(size: 16))
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            Text(shop.address)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                    }
//                    .padding(.horizontal, 15)
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(15)
//
//                    // Add spacing between shop items
//                    if index != filteredLikedShops.count - 1 {
//                        Spacer().frame(height: 20)
//                    }
//                }
//            }
//            .padding()
//        }
//    }
//
//    var filteredLikedShops: [Shop] {
//        if searchText.isEmpty {
//            return homeData.likedShops
//        } else {
//            return homeData.likedShops.filter { shop in
//                return shop.storename.localizedCaseInsensitiveContains(searchText)
//            }
//        }
//    }
//}
//struct LikedShop_Previews: PreviewProvider {
//    static var previews: some View {
//        // Initialize a homeViewModel and pass it to LikedShop
//        LikedShop(homeData: homeViewModel())
//    }
//}
// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import SwiftUI

struct LikedShop: View {
    @ObservedObject var homeData: homeViewModel
    @State private var searchText = ""
    @State private var isSortingAlphabetically = false
    @State private var originalLikedShops: [Shop]?

    init(homeData: homeViewModel) {
        self.homeData = homeData
        homeData.fetchLikedShops()
    }

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Liked Shops")
                        .font(.title)
                        .padding(.top, 20)

                    Button(action: {
                        isSortingAlphabetically.toggle()
                        if isSortingAlphabetically {
                            if originalLikedShops == nil {
                                originalLikedShops = homeData.likedShops
                            }
                            homeData.likedShops.sort { $0.storename < $1.storename }
                        } else {
                            if let originalShops = originalLikedShops {
                                homeData.likedShops = originalShops
                            }
                            originalLikedShops = nil
                        }
                    }) {
                        Image(systemName: isSortingAlphabetically ? "person.fill" : "person.fill")
                            .font(.title)
                    }
                }

                TextField("Search by Store Name", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)

                ForEach(filteredLikedShops.indices, id: \.self) { index in
                    let shop = filteredLikedShops[index]

                    HStack(alignment: .top, spacing: 10) {
                        AsyncImage(url: URL(string: shop.image)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(shop.storename)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(shop.address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 15)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)

                    if index != filteredLikedShops.count - 1 {
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
