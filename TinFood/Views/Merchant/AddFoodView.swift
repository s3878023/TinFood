//
//  AddFoodView.swift
//  TinFood
//
//  Created by Nhật Quân on 15/09/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct AddFoodView: View {
    @EnvironmentObject var shopViewModel: ShopViewModel
    @Binding var newFood: FoodTest
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil


    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Details")) {
                    TextField("Food Name", text: Binding<String>(
                        get: { newFood.foodname ?? "" },
                        set: { newValue in newFood.foodname = newValue }
                    ))
                    TextField("Price", text: Binding<String>(
                        get: { newFood.price ?? "" },
                        set: { newValue in newFood.price = newValue }
                    ))
                    TextField("Description", text: Binding<String>(
                        get: { newFood.description ?? "" },
                        set: { newValue in newFood.description = newValue }
                    ))
                    TextField("Image URL", text: Binding<String>(
                        get: { newFood.image ?? "" },
                        set: { newValue in newFood.image = newValue }
                    ))
                    TextField("Category", text: Binding<String>(
                        get: { newFood.category ?? "" },
                        set: { newValue in newFood.category = newValue }
                    ))
                }

                Section {
                    Button("Add Food") {
                        // Call the function in ShopViewModel to add the food
                        shopViewModel.addFood(newFood: newFood)
                    }
                }
            }
            .navigationTitle("Add Food")
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    @State static var newFood = FoodTest() // Provide a default FoodTest object

    static var previews: some View {
        AddFoodView(newFood: $newFood) // Provide the binding to the newFood parameter
    }
}
