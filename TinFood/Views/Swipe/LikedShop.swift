/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Duc Dai  ID: s3878023
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

struct LikedShop: View {
    @ObservedObject var homeData: homeViewModel
    @State private var searchText = ""
    @State private var isSortingAlphabetically = false
    @State private var originalLikedShops: [Shop]?

    init(homeData: homeViewModel) {
        self.homeData = homeData
        homeData.fetchLikedShops()
    }

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Liked Shops")
                        .font(.title.bold())
                        .padding(.top, 20)
                        .foregroundColor(Color("swipe"))

                    Button(action: {
                        isSortingAlphabetically.toggle()
                        if isSortingAlphabetically {
                            if originalLikedShops == nil {
                                originalLikedShops = homeData.likedShops
                            }
                            homeData.likedShops.sort { $0.storename < $1.storename }
                        } else {
                            if let originalShops = originalLikedShops {
                                homeData.likedShops = originalShops
                            }
                            originalLikedShops = nil
                        }
                    }) {
                        Image(systemName: isSortingAlphabetically ? "character.book.closed.fill" : "chart.bar.doc.horizontal")
                            .padding(.top, 20)
                            .font(.title)
                            .foregroundColor(Color("myGreen"))
                    }
                }
                TextField("Search by Store Name", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)

                ForEach(filteredLikedShops.indices, id: \.self) { index in
                    let shop = filteredLikedShops[index]

                    HStack(alignment: .top, spacing: 10) {
                        AsyncImage(url: URL(string: shop.image)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(shop.storename)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 15)
                            Text(shop.address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 15)
                    .background(Color("swipe").opacity(0.5))
                    .cornerRadius(15)

                    if index != filteredLikedShops.count - 1 {
                        Spacer().frame(height: 20)
                    }
                }
            }
            .padding()
        }
        .background(Color("background"))
    }

    var filteredLikedShops: [Shop] {
        if searchText.isEmpty {
            return homeData.likedShops
        } else {
            return homeData.likedShops.filter { shop in
                return shop.storename.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

struct LikedShop_Previews: PreviewProvider {
    static var previews: some View {
        LikedShop(homeData: homeViewModel())
    }
}
