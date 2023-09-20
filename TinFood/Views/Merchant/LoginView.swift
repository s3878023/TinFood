

import SwiftUI
import Firebase

struct LoginView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var isRegisterSheetPresented = false
    @State private var username = ""
    @State private var password = ""
    @State private var showRegisterAlert = false
    @State private var registerUsername = ""
    @State private var registerPassword = ""
    @State private var registerConfirmPassword = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var wrongRegisterPassword = 0
    @State private var showingLoginScreen = false
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView{
            VStack{
                Image("GwentIcon")
                    .resizable()
                    .scaledToFit()
                
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongPassword))
                
                Button("Login", action: {loginViewModel.login(username: self.username, password: self.password)})
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                Button("Register") {
                    isRegisterSheetPresented.toggle() // Toggle the sheet's visibility
                }
                .padding()
                .sheet(isPresented: $isRegisterSheetPresented) {
                    VStack {
                        
                        Image("GwentIcon")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Register Account")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        
                        TextField("Username", text: $registerUsername)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongUsername))
                        
                        SecureField("Password", text: $registerPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
//                                        .border(.red, width: CGFloat(wrongPassword))
                        
                        SecureField("Confirm Password", text: $registerConfirmPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongRegisterPassword))
                        
                        Button("Register") {
                            // Check if the password and confirm password match
                            if registerPassword == registerConfirmPassword {
                                loginViewModel.register(username: registerUsername, password: registerPassword)
                                showRegisterAlert = true
                            } else {
                                // Passwords don't match, handle this case (e.g., show an error message)
                                print("Passwords do not match")
                                showRegisterAlert = true
                                wrongRegisterPassword = 2
                            }
                        }
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                            .alert(isPresented: $showRegisterAlert) {
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
                                            // Optionally, you can perform any action after a successful registration
                                            // For example, you might navigate to another view or close the registration sheet.
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
                NavigationLink(destination: Home(), isActive: $loginViewModel.loginSuccess) {
                }
            )
            .navigationBarBackButtonHidden(true)
        }
    }


}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
}
