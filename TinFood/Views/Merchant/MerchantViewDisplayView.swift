//
//  MerchantViewDisplayView.swift
//  TinFood
//
//  Created by Nhật Quân on 19/09/2023.
//

import SwiftUI

struct MerchantViewDisplayView: View {
    // @State private var merchant: String = "" // You can remove this line if it's not used

    // Our merchant view model object
    @StateObject private var merchantViewModel = MerchantViewModel()

    var body: some View {
        VStack {
            // Input field for a movie name (if needed)

            NavigationView {
                List {
                    ForEach(merchantViewModel.merchants, id: \.id) { merchant in
                        Text(merchant.storename ?? "")
                        Text(merchant.username ?? "")
                        Text(merchant.password ?? "")
                        Text(merchant.description ?? "")
                        AsyncImage(url: URL(string: merchant.image ?? "")) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder or loading view if needed
                                Text("Loading...")
                            case .success(let image):
                                image
                                    .resizable() // Make the image resizable
                                    .scaledToFit() // Maintain aspect ratio
                            case .failure:
                                // Handle error if image fails to load
                                Text("Image loading failed")
                            @unknown default:
                                // Handle unknown cases or provide a fallback view
                                Text("Unknown state")
                            }
                        }
                        .frame(width: 100, height: 100)
                    }
                }
                .navigationTitle("All Movies")

            }

        }
    }
}

struct MerchantViewDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantViewDisplayView()
    }
}

