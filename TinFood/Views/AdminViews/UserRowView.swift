//
//  UserRowView.swift
//  TinFoodTest
//
//  Created by Donnie Tran on 9/14/23.
//

import Foundation
import SwiftUI

struct UserRowView: View {
    let user: UserModel
    @ObservedObject var viewModel: HomeViewModel
    @State private var showBanOptions = false
    
    var body: some View {
        if (user.isMerchant == false){
            HStack {
                Text(user.name)
                    .font(.system(size: 20))
                Spacer()
                Button(action: {
                    viewModel.banUser(user: user)
                }) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90.0))
                        .foregroundColor(Color("CustomedOrange"))
                }
                .popover(isPresented: $showBanOptions) {
                    BanOptionsView(user: user)
                }
                .sheet(isPresented: $viewModel.showMoreOptions) {
                    // Add the view for more options here
                    Text("More Options for \(user.name)")
                }
            }
            .onTapGesture {
                viewModel.showMoreOptions.toggle()
            }
        }
    }
}
