//
//  ShowMoreOptionsMercView.swift
//  TinFood
//
//  Created by Donnie Tran on 9/22/23.
//

import SwiftUI

struct ShowMoreOptionViewMerc: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        if let selectedShop = viewModel.selectedShop {
            Text("More Information about \(selectedShop.storename)")
        } else {
            Text("No shop selected") // Display a message when no user is selected
        }
    }
}
