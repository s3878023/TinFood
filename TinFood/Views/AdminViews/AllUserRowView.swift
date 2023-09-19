//
//  AllUserRowView.swift
//  TinFood
//
//  Created by Donnie Tran on 9/15/23.
//

import Foundation
import SwiftUI

struct AllUserRowView: View {
    @State var user: UserModel
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Text(user.name ?? "")
                .font(.system(size: 20))
            Spacer()
            Button(action: {
                // Add any action you want when the button is tapped
            }) {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90.0))
                    .foregroundColor(Color("CustomedOrange"))
            }
            .sheet(isPresented: $viewModel.showMoreOptions) {
                // Add the view for more options here
                Text("More Options for \(user.name ?? "")")
            }
        }
        .onTapGesture {
            viewModel.showMoreOptions.toggle()
        }
    }
}

