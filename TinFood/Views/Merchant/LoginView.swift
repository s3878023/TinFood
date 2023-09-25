/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quoc An  ID: s3938278
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
import Firebase

struct LoginView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var isRegisterSheetPresented = false
    @State private var username = ""
    @State private var password = ""
    @State private var registerUsername = ""
    @State private var registerPassword = ""
    @State private var registerConfirmPassword = ""
    @State private var registerAddress = ""
    @State private var registerStoreName = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var wrongRegisterPassword = 0
    @State private var showingLoginScreen = false
    @State private var isLoggedIn = false
    @State private var loginAs = "User"
    @State private var registerAs = "User"
    @State private var profileImageUrl: URL?
    let loginOptions = ["User", "Shop", "Admin"]
    let registerOptions = ["User", "Shop"]
    
    var body: some View {
        NavigationView{
            VStack{
                Image("Logo")
                    .offset(y:100)
                    
                Spacer()
                
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(Color("button"))
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                    .foregroundColor(.black)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongPassword))
                    .foregroundColor(.black)

                
                Picker("Login as", selection: $loginAs) {
                    ForEach(loginOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300, height: 35)
                    .cornerRadius(10)
                
                Button("Login", action: {loginViewModel.login(username: self.username, password: self.password, role: self.loginAs)})
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color("button"))
                    .cornerRadius(10)
                Button("Register") {
                    isRegisterSheetPresented.toggle() // Toggle the sheet's visibility
                }
                .padding()
                .foregroundColor(Color("button"))
                .sheet(isPresented: $isRegisterSheetPresented) {
                    VStack {
                        
                        Image("GwentIcon")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Register Account")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .foregroundColor(Color("button"))
                        
//                        Text($profileImageUrl)
                        ImageUploadView(imageURL: $profileImageUrl)
                        
                        TextField("Username", text: $registerUsername)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongUsername))
                            .foregroundColor(.black)

                        
                        SecureField("Password", text: $registerPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .foregroundColor(.black)

//                                        .border(.red, width: CGFloat(wrongPassword))
                        
                        SecureField("Confirm Password", text: $registerConfirmPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongRegisterPassword))
                            .foregroundColor(.black)

                        
                        // Use a conditional statement to display fields based on the selected value of the Picker
                        if registerAs == "Shop" {
                            TextField("Address", text: $registerAddress)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .border(.red, width: CGFloat(wrongUsername))
                                .foregroundColor(.black)

                            
                            TextField("Store Name", text: $registerStoreName)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .border(.red, width: CGFloat(wrongUsername))
                                .foregroundColor(.black)
                            

                        }
                        
                        Picker("Register as", selection: $registerAs) {
                            ForEach(registerOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 300, height: 35)
                            .cornerRadius(10)
                            .foregroundColor(.black)

                        
                        Button("Register") {
                            // Check if the password and confirm password match
                            if registerPassword == registerConfirmPassword {
                                if registerPassword == registerConfirmPassword {
                                    if registerAs == "User" {
                                        loginViewModel.register(
                                            username: registerUsername,
                                            password: registerPassword,
                                            profileImageUrlString: profileImageUrl?.absoluteString ?? "https://firebasestorage.googleapis.com/v0/b/tinfood-17312.appspot.com/o/avatar.png?alt=media&token=c644573a-9f61-4dd5-a050-1130233a9143"
                                        )
                                    } else if registerAs == "Shop" {
                                        loginViewModel.registerShop(
                                            username: registerUsername,
                                            password: registerPassword,
                                            profileImageUrlString: profileImageUrl?.absoluteString ?? "https://firebasestorage.googleapis.com/v0/b/tinfood-17312.appspot.com/o/avatar.png?alt=media&token=c644573a-9f61-4dd5-a050-1130233a9143",
                                            restaurantName: registerStoreName,
                                            address: registerAddress
                                        )
                                    }
                                }

                            } else {
                                print("Passwords do not match")
                                wrongRegisterPassword = 2
                            }
                        }
                            .foregroundColor(Color("background"))
                            .frame(width: 300, height: 50)
                            .background(Color("button"))
                            .cornerRadius(10)
                            .alert(isPresented: $loginViewModel.showRegisterAlert) {
                                if registerPassword != registerConfirmPassword{
                                    return Alert(
                                        title: Text("Password Mismatch"),
                                        message: Text("Passwords do not match. Please try again."),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                                
                                if loginViewModel.registrationSuccess {
                                    // Registration succeeded, show a success alert
                                    return Alert(
                                        title: Text("Registration Success"),
                                        message: Text("You have successfully registered."),
                                        dismissButton: .default(Text("OK")) {
                                            isRegisterSheetPresented.toggle()
                                        }
                                    )
                                } else {
                                    // Registration failed, show a failure alert with the error message
                                    return Alert(
                                        title: Text("Registration Failed"),
                                        message: Text(loginViewModel.registrationError),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                            }
                        
                        Button("Close") {
                            isRegisterSheetPresented.toggle() // Close the sheet
                        }
                        .padding()
                    }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .onAppear {
                    showingLoginScreen = false // Show the login screen initially
                        }
            .background(
                NavigationLink(destination: Home( loginViewModel: loginViewModel), isActive: $loginViewModel.loginSuccess) {
                }
            )
            .foregroundColor(Color("background"))
            .navigationBarBackButtonHidden(true)
        }
    }


}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
}
