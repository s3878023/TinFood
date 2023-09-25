//
//  FoodViewModel.swift
//  TinFood
//
//  Created by Nhật Quân on 15/09/2023.
//

import Foundation
import SwiftUI

class FoodViewModel: ObservableObject {
    @Published var foods : [Food] = []
    
    init(){
        addFood()
    }
    func addFood(){
        foods = foodData
    }
    func logic1(){
        
    }
    func logic2(){
        
    }
}

let foodData = [
    Food(name: "Fried Chicken", image: "chicken", description: "this is chicken", category: "chicken", price: 50000),
    Food(name: "Fried Chicken", image: "chicken", description: "this is chicken", category: "chicken", price: 50000),
    Food(name: "Fried Chicken", image: "chicken", description: "this is chicken", category: "chicken", price: 50000),
    Food(name: "Fried Chicken", image: "chicken", description: "this is chicken", category: "chicken", price: 50000)
]
