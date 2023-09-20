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
                        HStack{

                        }
                            ForEach(merchant.username ?? [], id: \.self) { username in
                                Text(username)
                            }


                            ForEach(merchant.password ?? [], id: \.self) { password in
                                Text(password)
                            }

                            ForEach(merchant.storename ?? [], id: \.self) { storename in
                                Text(storename)
                            }
                            ForEach(merchant.image ?? [], id: \.self) { imageURL in
                                AsyncImage(url: URL(string: imageURL)) { phase in
                                    switch phase {
                                    case .empty:
                                        // Placeholder or loading view if needed
                                        Text("Loading...")
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
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
                }
                .navigationTitle("All Merchants")
            }

        }
    }
}

struct MerchantViewDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantViewDisplayView()
    }
}

