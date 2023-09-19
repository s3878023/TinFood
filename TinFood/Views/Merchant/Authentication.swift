//
//  LoginView.swift
//  TinFood
//
//  Created by Nhật Quân on 19/09/2023.
//

import SwiftUI

struct Authentication: View {
    var body: some View {
        VStack{
            NavigationLink{
                Text("Hello")
            } label:{
                Text("Sign in with email")
                    .foregroundColor(Color(.black))
                    .frame(height: 50)
            }
            Spacer()
            
        }
        .navigationTitle("Sign in")
    }
}

struct Authentication_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Authentication()
        }
       
    }
}
