//
//  MerchantForUserView.swift
//  TinFood
//
//  Created by Quan Tong Nhat on 21/09/2023.
//

import SwiftUI

struct MerchantForUserView: View {
    @StateObject private var merchantViewModel = MerchantViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                VStack{
                    HStack() {
                        Image("store")
                            .resizable()
                            .frame(width: 75,height: 75)
                        VStack(alignment: .leading){Text("McDonald")
                                .fontWeight(.bold)
                            Text("Address")
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: 350)
                    .padding(.bottom)
//                      HStack{
//                          NavigationLink {
//                              // destination view to navigation to
//                              CouponView()
//                          } label: {
//                              Text("Coupon")
//                                  .padding(.leading)
//                                  .fontWeight(.bold)
//                              Spacer()
//                              Image(systemName: "arrow.right.circle")
//                                  .foregroundColor(Color("button"))
//                                  .frame(width: 50,height: 50)
//                          }
//                      }
//                      .frame(height: 50)
//                      .overlay(
//                              RoundedRectangle(cornerRadius: 16)
//                                  .stroke(Color("components"), lineWidth: 3)
//                          )
//                      .frame(maxWidth: 350)
//                      .padding(.bottom,10)
                    HStack{
                        Text("Food")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .frame(height: 50)
                    .frame(maxWidth: 350)
                    ForEach(merchantViewModel.merchants, id: \.id) { merchant in
                        HStack{
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
                                Text(merchant.foodname ?? "")
                                    .font(.system(size:20))
                                Text(merchant.description ?? "")
                                    .font(.system(size:12))
                            }
                            Spacer()
                            VStack(alignment: .trailing){
                                Text(merchant.price ?? "")
                                    .fontWeight(.bold)
                                    .font(.system(size:20))
                                Text(merchant.category ?? "")
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
            }
            .foregroundStyle(Color("text"))
            .ignoresSafeArea(.all)
           
        }
        .navigationBarBackButtonHidden(true)
       

    }
}

struct MerchantForUserView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantForUserView()
    }
}
