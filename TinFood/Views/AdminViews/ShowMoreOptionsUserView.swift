//
//  ShowMoreOptionsUserView.swift
//  TinFood
//
//  Created by Donnie Tran on 9/22/23.
//
import SwiftUI

struct ShowMoreOptionView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        if let selectedUser = viewModel.selectedUser {
            Text("More Information about \(selectedUser.name)")
        } else {
            Text("No user selected") // Display a message when no user is selected
        }
    }
}
