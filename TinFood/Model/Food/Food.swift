//
//  Food.swift
//  TinFood
//
//  Created by Nhật Quân on 15/09/2023.
//

//
import Foundation
import SwiftUI

struct Food: Identifiable{
    var id = UUID()
    var name, image, description, category : String
    var price : Int
    
    var imageName: Image {
        Image(image)
    }
}
