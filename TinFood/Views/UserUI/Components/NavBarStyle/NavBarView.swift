//
//  NavBarView.swift
//  Tinfood
//
//  Created by Khoa Dang Hoang Anh on 13/09/2023.
//

import SwiftUI

struct NavBarView: View {
    var body: some View {
        NavCustomView {
                ZStack{
                    Color(hex: 0xfaf1e8).ignoresSafeArea()
                    
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            Text("Navigate")
                    }
                )
            }
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
    }
}

extension NavBarView {
    private var NavViewDefault: some View {
        NavigationView{
            ZStack {
                Color(hex: 0xfcd4c8).ignoresSafeArea()
                
                NavigationLink(
                    destination:
                        Text("Destination")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false)
                    , label: {
                        Text("Navigate")
                    }
                )
            }
            .navigationTitle("Title")
        }
    }
}
