/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Duc Dai  ID: s3878023
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

struct splashView: View {
    @State var isActive = false
    var body: some View {
        if isActive {
            ContentView()
        }else{
            VStack{
                VStack{
                    Image("Logo")
                        .padding(.top, 30)
                    GIFView(gifName: "food")
                    GIFView(gifName: "load")
                }
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)) {}
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0){
                    self.isActive = true
                }
            } 
        }
    }
}

struct splashView_Previews: PreviewProvider {
    static var previews: some View {
        splashView()
    }
}
