/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tranh Khanh Duc  ID: s3907087
  Created  date: 15/09/2023.
  Last modified: 25/09/2023
  Acknowledgement:
    RMIT Lecture Slides https://rmit.instructure.com/courses/121597
    OpenChatAI: https://chat.openai.com/
    Github: https://github.com/s3878023/TinFood/tree/dev
    SFSymbols
    StackOverFlow: https://stackoverflow.com/
*/
import SwiftUI

struct ShowMoreOptionView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isDeleteConfirmationVisible = false
    @State private var selectedIndexToDelete: Int?

    var body: some View {
        if let selectedUser = viewModel.selectedUser {
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                VStack() {
                    AsyncImage(url: URL(string: selectedUser.profilePic ?? "")) { phase in
                        switch phase {
                        case .empty:
                            // Placeholder or loading view if needed
                            Text("Loading...")
                        case .success(let image):
                            image
                                .padding(.bottom, 10.0)
                                .frame(width:260, height:260)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color(.white), lineWidth: 3)
                                )
                                .shadow(color: .gray, radius: 7)
                        case .failure:
                            // Handle error if image fails to load
                            Text("Image loading failed")
                        @unknown default:
                            // Handle unknown cases or provide a fallback view
                            Text("Unknown state")
                        }
                    }
                    .padding(.vertical,30)
                    HStack {
                        Text("Name:")
                            .offset(x: 10, y: 0)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color("button")) // Customize the text color if needed
                        Spacer()
                        Text(selectedUser.name)
                            .foregroundColor(Color("text"))
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .fontWeight(.regular) // Customize font weight if needed
                        Spacer()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("row"))
                            .frame(height: 50)

                    )
                    .padding(.bottom, 50)
                    // Shop address
                    HStack {
                        Text("Address:")
                            .offset(x: 10, y: 0)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color("button")) // Customize the text color if needed
                        Spacer()
                        Text(selectedUser.place ?? "")
                            .foregroundColor(Color("text"))
                            .font(.body)
                            .fontWeight(.regular) // Customize font weight if needed
                        Spacer()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("row"))
                            .frame(height: 50)
                    )
                    .padding(.bottom, 30)
                    Image(systemName: "trash")
                        .onTapGesture {
                            selectedIndexToDelete = viewModel.users.firstIndex { $0.id == selectedUser.id }
                            isDeleteConfirmationVisible = true
                        }
                        .foregroundColor(Color.red)
                        .font(.system(size: 30))
                }
                .frame(maxWidth: 350)
                .padding(.bottom)
            }
            .alert(isPresented: $isDeleteConfirmationVisible) {
                Alert(
                    title: Text("Delete Shop"),
                    message: Text("Are you sure you want to delete this shop?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let indexToDelete = selectedIndexToDelete {
                            if let documentID = viewModel.users[indexToDelete].documentID {
                                viewModel.removeUserData(documentID: documentID)
                            }
                        }
                        selectedIndexToDelete = nil
                        isDeleteConfirmationVisible = false
                    },
                    secondaryButton: .cancel(Text("Cancel")) {
                        selectedIndexToDelete = nil
                        isDeleteConfirmationVisible = false
                    }
                )
            }
        } else {
            Text("No shop selected")
        }
    }
}
