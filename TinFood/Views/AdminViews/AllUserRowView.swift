//
//  AllUserRowView.swift
//  TinFood
//
//  Created by Donnie Tran on 9/15/23.
//

import Foundation
import SwiftUI

struct AllUserRowView: View {
    let user: UserModel // Assuming you have UserModel for merchants
    @ObservedObject var viewModel: HomeViewModel
    @State private var showBanOptions = false
    
    var body: some View {
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
