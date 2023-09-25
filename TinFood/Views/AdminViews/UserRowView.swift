import Foundation
import SwiftUI

struct UserRowView: View {
    @State var user: UserModel
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Text(user.name)
                .font(.system(size: 20))
            Spacer()
            Button(action: {
                viewModel.selectedUser = user // Set the selectedUser property
                viewModel.showMoreOptions.toggle()
            }) {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90.0))
                    .foregroundColor(Color("button"))
            }
        }
    }
}
