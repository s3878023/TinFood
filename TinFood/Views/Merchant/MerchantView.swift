//
//  MerchantView.swift
//  TinFood
//
//  Created by Nhật Quân on 15/09/2023.
//

import SwiftUI
import Firebase


struct MerchantView: View {
    //    @ObservedObject var foodModel = FoodViewModel()
    @StateObject private var merchantViewModel = MerchantViewModel()
    @StateObject private var shopViewModel = ShopViewModel()
    @State private var showAddFoodSheet = false
    @State private var newFood = FoodTest()
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background") 
                VStack{
                    ForEach(shopViewModel.shoptests, id: \.id) { shopTest in
                        if let foodTests = shopTest.foodTests {
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
                                        .font(.system(size: 24))
                                    Text(shopTest.address ?? "")
                                        .fontWeight(.bold)
                                        .font(.system(size: 12))
                                }
                                Spacer()
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(Color("button"))
                                
                            }
                            .frame(maxWidth: 350)
                            .padding(.bottom)
                            HStack{
                                Text("Food")
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: ImageUploadView(newFood: $newFood).environmentObject(shopViewModel)) {
                                    Text("Add new food")
                                        .foregroundColor(Color("button"))
                                        .fontWeight(.bold)
                                }
                            }
                            .frame(height: 50)
                            .frame(maxWidth: 350)
                            
                            ForEach(foodTests) { foodTest in
                                HStack{
                                    AsyncImage(url: URL(string: foodTest.image ?? "")) { phase in
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
                                        Text(foodTest.foodname ?? "")
                                            .font(.system(size:20))
                                        Text(foodTest.description ?? "")
                                            .font(.system(size:12))
                                        
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text(foodTest.price ?? "")
                                            .fontWeight(.bold)
                                            .font(.system(size:20))
                                        Text(foodTest.category ?? "")
                                            .font(.system(size:12))
                                    }

                                    Button(action: {
                                        shopViewModel.deleteFoodItem(foodTest: foodTest)
                                        }) {
                                            Image(systemName: "trash.fill") 
                                                .foregroundColor(.red)
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
                        
                        
                        
                    }
                }
            }
            .foregroundStyle(Color("text"))
            .ignoresSafeArea(.all)
            
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}

struct MerchantView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantView()
    }
}

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
