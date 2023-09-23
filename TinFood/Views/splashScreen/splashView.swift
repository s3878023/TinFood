//
//  splashView.swift
//  TinFood
//
//  Created by Đại Đức on 23/09/2023.
//

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
