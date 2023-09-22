//
//  ListView.swift
//  TinFood
//
//  Created by Nhật Quân on 22/09/2023.
//

import SwiftUI

struct ListView: View {
    @StateObject private var merchantViewModel = MerchantViewModel()
    @StateObject private var shopViewModel = ShopViewModel()
    @StateObject private var listShopViewModel = ListViewModel()
      var body: some View {
          NavigationStack{
              ZStack{
                  Color("background")
                  VStack{
                      ForEach(listShopViewModel.shoptests, id: \.id) { shopTest in
                          
                          HStack() {
                              AsyncImage(url: URL(string: shopTest.image ?? "")) { phase in
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
                                  .frame(width: 75,height: 75)
                              VStack(alignment: .leading){Text(shopTest.storename ?? "")
                                      .fontWeight(.bold)
                                  Text(shopTest.address ?? "")
                                      .font(.system(size:16))
                              }
                              Spacer()
                             
                          }
                          .frame(maxWidth: 350)
                          .padding(.bottom)
//                          HStack{
//                              AsyncImage(url: URL(string: merchant.image ?? "")) { phase in
//                                  switch phase {
//                                  case .empty:
//                                      // Placeholder or loading view if needed
//                                      Text("Loading...")
//                                  case .success(let image):
//                                      image
//                                          .resizable() // Make the image resizable
//                                          .aspectRatio(contentMode: .fit)
//                                          .frame(width:90)
//                                  case .failure:
//                                      // Handle error if image fails to load
//                                      Text("Image loading failed")
//                                  @unknown default:
//                                      // Handle unknown cases or provide a fallback view
//                                      Text("Unknown state")
//                                  }
//                              }
//                              .frame(width: 100, height: 100)
//                              VStack(alignment: .leading){
//                                  Text(merchant.foodname ?? "")
//                                      .font(.system(size:20))
//                                  Text(merchant.description ?? "")
//                                      .font(.system(size:12))
//
//                              }
//                              Spacer()
//                              VStack(alignment: .trailing){
//                                  Text(merchant.price ?? "")
//                                      .fontWeight(.bold)
//                                      .font(.system(size:20))
//                                  Text(merchant.category ?? "")
//                                      .font(.system(size:12))
//                              }
//                          }
//                          .frame(height : 80)
//                          .frame(maxWidth: 350)
//                          Divider()
//                           .frame(height: 1)
//                           .background(Color("components"))
//                           .frame(maxWidth: 350)
                        
                          
                      }
                  }
              }
              .foregroundStyle(Color("text"))
              .ignoresSafeArea(.all)
             
          }
          .navigationBarBackButtonHidden(true)
         

      }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
