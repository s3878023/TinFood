//
//  MerchantRowView.swift
//  TinFood
//
//  Created by Donnie Tran on 9/15/23.
//

import Foundation
import SwiftUI

struct MerchantsRowView: View {
    let merchant: UserModel // Assuming you have UserModel for merchants
    @ObservedObject var viewModel: HomeViewModel
    @State private var showBanOptions = false
    
    var body: some View {
        if (merchant.isMerchant == true){
            HStack {
                Text(merchant.name)
                    .font(.system(size: 20))
                Spacer()
                Button(action: {
                    viewModel.banUser(user: merchant)
                }) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90.0))
                        .foregroundColor(Color("CustomedOrange"))
                }
                .popover(isPresented: $showBanOptions) {
                    BanOptionsView(user: merchant)
                }
                .sheet(isPresented: $viewModel.showMoreOptions) {
                    // Add the view for more options here
                    Text("More Options for \(merchant.name)")
                }
            }
            .onTapGesture {
                viewModel.showMoreOptions.toggle()
            }
        }
    }
}
