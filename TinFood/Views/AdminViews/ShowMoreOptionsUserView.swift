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
            HStack() {
                AsyncImage(url: URL(string: selectedUser.profilePic ?? "")) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder or loading view if needed
                        Text("Loading...")
                    case .success(let image):
                        image
                            .resizable() // Make the image resizable
                            .aspectRatio(contentMode: .fit)
                            .frame(width:90)
                    case .failure:
                        // Handle error if image fails to load
                        Text("Image loading failed")
                    @unknown default:
                        // Handle unknown cases or provide a fallback view
                        Text("Unknown state")
                    }
                }
                .frame(width: 75,height: 75)
                VStack(alignment: .leading){Text(selectedUser.name)
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                    Text(selectedUser.place ?? "")
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                }
                Spacer()
            }
            .frame(maxWidth: 350)
            .padding(.bottom)
        } else {
            Text("No user selected") // Display a message when no user is selected
        }
    }
}
