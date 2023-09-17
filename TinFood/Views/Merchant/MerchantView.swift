//
//  MerchantView.swift
//  TinFood
//
//  Created by Nhật Quân on 15/09/2023.
//

import SwiftUI

struct MerchantView: View {
    @ObservedObject var foodModel = FoodViewModel()
      var body: some View {
          NavigationStack{
              ZStack{
                  Color("background")
                  VStack{
                      HStack() {
                          Image("store")
                              .resizable()
                              .frame(width: 75,height: 75)
                          Text("McDonald")
                              .fontWeight(.bold)
                          Spacer()
                          Image(systemName: "person.circle.fill")
                              .font(.system(size: 40))
                              .foregroundColor(Color("button"))
                      }
                      .frame(maxWidth: 350)
                      .padding(.bottom)
                      HStack{
                          NavigationLink {
                              // destination view to navigation to
                             CouponView()
                          } label: {
                              Text("Order")
                                  .padding(.leading)
                                  .fontWeight(.bold)
                              Spacer()
                              Image(systemName: "arrow.right.circle")
                                  .foregroundColor(Color("button"))
                                  .frame(width: 50,height: 50)
                          }
                      }
                      .frame(height: 50)
                      .overlay(
                              RoundedRectangle(cornerRadius: 16)
                                  .stroke(Color("components"), lineWidth: 3)
                          )
                      .frame(maxWidth: 350)
                      .padding(.bottom,10)
                      HStack{
                          NavigationLink {
                              // destination view to navigation to
                              CouponView()
                          } label: {
                              Text("Coupon")
                                  .padding(.leading)
                                  .fontWeight(.bold)
                              Spacer()
                              Image(systemName: "arrow.right.circle")
                                  .foregroundColor(Color("button"))
                                  .frame(width: 50,height: 50)
                          }
                      }
                      .frame(height: 50)
                      .overlay(
                              RoundedRectangle(cornerRadius: 16)
                                  .stroke(Color("components"), lineWidth: 3)
                          )
                      .frame(maxWidth: 350)
                      .padding(.bottom,10)
                      HStack{
                          Text("Food")
                              .fontWeight(.bold)
                          Spacer()
                          NavigationLink(destination: AddFoodView(), label: {Text("Add new food")
                                  .foregroundColor(Color("button"))
                                  .fontWeight(.bold)})
                      }
                      .frame(height: 50)
                      .frame(maxWidth: 350)
                      ForEach(foodModel.foods) { food in
                          HStack{
                              food.imageName
                                  .resizable()
                                  .aspectRatio(contentMode: .fit
                                  )
                                  .frame(width:100)
                              VStack(alignment: .leading){
                                  Text(food.name)
                                      .font(.system(size:20))
                                  Text(food.description)
                                      .font(.system(size:12))
                                    
                              }
                              Spacer()
                              VStack(alignment: .trailing){
                                  Text("\(food.price)")
                                      .fontWeight(.bold)
                                      .font(.system(size:20))
                                  Text(food.category)
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
              .edgesIgnoringSafeArea(.all)
              
          }
         

      }
}

struct MerchantView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantView()
    }
}
