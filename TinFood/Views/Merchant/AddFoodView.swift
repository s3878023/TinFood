//
//  AddFoodView.swift
//  TinFood
//
//  Created by Nhật Quân on 15/09/2023.
//

import SwiftUI

struct AddFoodView: View {
    @EnvironmentObject var shopViewModel: ShopViewModel // Inject ShopViewModel
       @Binding var newFood: FoodTest // Binding to the new food item

       var body: some View {
           // Your form for adding a new food item
           // ...
           
           Button("Add Food") {
               // Call the function in ShopViewModel to add the food
               shopViewModel.addFood(newFood: newFood)
           }
       }
}

struct AddFoodView_Previews: PreviewProvider {
    @State static var newFood = FoodTest() // Provide a default FoodTest object

    static var previews: some View {
        AddFoodView(newFood: $newFood) // Provide the binding to the newFood parameter
    }
}
