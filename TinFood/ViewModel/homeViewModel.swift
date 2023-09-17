//
//  homeViewModel.swift
//  TinFood
//
//  Created by Đại Đức on 17/09/2023.
//

import SwiftUI

class homeViewModel: ObservableObject {
    @Published var fetch_shops: [Shop] = []
    @Published var displaying_shops: [Shop]?
    @Published var likedShops: [String] = []
    @Published var dislikedShops: [String] = []

    
    init(){
        fetch_shops = [
            Shop(name: "Burger1", place: "HCM", profilePic: "1"),
            Shop(name: "Burger2", place: "HCM", profilePic: "2"),
            Shop(name: "Burger3", place: "HCM", profilePic: "3"),
            Shop(name: "Burger4", place: "HCM", profilePic: "4"),
            Shop(name: "Burger5", place: "HCM", profilePic: "5"),
            Shop(name: "Burger6", place: "HCM", profilePic: "6")
        ]
        displaying_shops = fetch_shops
    }
    func getIndex(shop: Shop) -> Int{
        let index = displaying_shops?.firstIndex(where: {currentShop in
            return shop.id == currentShop.id
        })  ?? 0
        return index
    }
}
