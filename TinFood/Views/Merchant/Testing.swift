
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tong Nhat Quan  ID: s3819347
  Created  date: 13/09/2023.
  Last modified: 25/09/2023
  Acknowledgement:
    RMIT Lecture Slides https://rmit.instructure.com/courses/121597
    OpenChatAI: https://chat.openai.com/
    Github: https://github.com/s3878023/TinFood/tree/dev
    SFSymbols
    StackOverFlow: https://stackoverflow.com/
*/

import SwiftUI

struct Testing: View {
    @ObservedObject var homeData: homeViewModel
    
    init(homeData: homeViewModel) {
        self.homeData = homeData
        homeData.fetchLikedShops() // Fetch the liked shops when the view is initialized
    }
    
    var body: some View {
        NavigationStack{
            List(homeData.likedShops){ shop in
                VStack{
                    Text(shop.storename)
                    Text(shop.address)
                }
            }
        }
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing(homeData:homeViewModel())
    }
}
