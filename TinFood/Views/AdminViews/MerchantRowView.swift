//
//  MerchantRowView.swift
//  TinFood
//
//  Created by Donnie Tran on 9/15/23.
//

import Foundation
import SwiftUI

struct MerchantsRowView: View {
    @State var merchant: Shop
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        HStack {
            Text(merchant.storename)
                .font(.system(size: 20))
            Spacer()
            Button(action: {
                viewModel.selectedShop = merchant // Set the selectedUser property
                viewModel.showMoreOptionsMerc.toggle()
            }) {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90.0))
                    .foregroundColor(Color("button"))
            }
        }
    }
}


