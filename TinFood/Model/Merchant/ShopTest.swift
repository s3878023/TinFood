//
//  Shop.swift
//  TinFood
//
//  Created by Nhật Quân on 21/09/2023.
//

import Foundation

import SwiftUI

struct ShopTest : Codable,Identifiable{
    var id: String = UUID().uuidString
    var username, password, storename, image,address: String?
    
}
