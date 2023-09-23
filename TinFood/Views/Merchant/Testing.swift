//
//  Testing.swift
//  TinFood
//
//  Created by Nhật Quân on 24/09/2023.
//

import SwiftUI

struct Testing: View {
    @ObservedObject private var viewModel = DetailedShopViewModel()
    var body: some View {
        NavigationView{
            List(viewModel.testinggs){ shop in
                VStack{
                    Text(shop.storename)
                    Text(shop.address)
                }
            }
        }
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
