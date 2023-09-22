//
//  FoodTest.swift
//  TinFood
//
//  Created by Nhật Quân on 21/09/2023.
//

import Foundation

struct FoodTest : Codable,Identifiable{
    var id: String = UUID().uuidString
    var foodname,price,description,image,category: String?
}
