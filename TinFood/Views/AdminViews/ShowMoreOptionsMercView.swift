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

struct ShowMoreOptionViewMerc: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isDeleteConfirmationVisible = false
    @State private var selectedIndexToDelete: Int?
    
    var body: some View {
        if let selectedShop = viewModel.selectedShop {
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                VStack() {
                    AsyncImage(url: URL(string: selectedShop.image)) { phase in
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
                    VStack {
                        VStack {
                            HStack {
                                Text("Name:")
                                    .offset(x: 10, y: 0)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("button")) // Customize the text color if needed
                                Spacer()
                                Text(selectedShop.storename)
                                    .foregroundColor(Color("text"))
                                    .offset(x:10, y:0)
                                    .font(.system(size: 25)) // You can adjust the initial font size
                                    .fontWeight(.regular) // Customize font weight if needed
                                    .lineLimit(nil) // Allow text to wrap
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 10) // Adjust the left padding
                                Spacer()
                            }
                            .frame(width: 350)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("row"))
                                    .frame(height: max(50, getTextHeight(selectedShop.storename)))
                            )
                        }
                        .padding(.bottom, 35)
                        VStack {
                            HStack {
                                Text("Address:")
                                    .offset(x: 10, y: 0)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("button")) // Customize the text color if needed
                                Spacer()
                                Text(selectedShop.address)
                                    .foregroundColor(Color("text"))
                                    .font(.system(size: 17)) // You can adjust the initial font size
                                    .fontWeight(.regular) // Customize font weight if needed
                                    .lineLimit(nil) // Allow text to wrap
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 10) // Adjust the left padding
                                Spacer()
                            }
                            .frame(width: 350)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("row"))
                                    .frame(height: max(50, getTextHeight(selectedShop.address)))
                            )
                        }
                    }
                    .padding(.bottom, 100)
                    Image(systemName: "trash")
                        .onTapGesture {
                            selectedIndexToDelete = viewModel.shops.firstIndex { $0.id == selectedShop.id }
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
                            if let documentID = viewModel.shops[indexToDelete].documentID {
                                viewModel.removeShopData(documentID: documentID)
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
    // Function to calculate the height of text based on its content
    private func getTextHeight(_ text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17) // You can adjust the font size
        let textWidth: CGFloat = 200 // You can adjust the width
        let boundingRect = CGSize(width: textWidth, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        
        let rect = NSString(string: text).boundingRect(
            with: boundingRect,
            options: options,
            attributes: attributes,
            context: nil
        )
        
        return ceil(rect.height)
    }
}
