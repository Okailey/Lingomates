import SwiftUI

struct LoginView: View {
    // Binding to control navigation state from the parent view
    @Binding var currentView: AppView
    
    // Local state for text fields
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color(.white) // Background color
                .edgesIgnoringSafeArea(.all) // Cover the whole screen
            VStack {
                Text("Login")
                    .font(.system(size: 32, weight: .medium))
                    .padding(100)
                
                // Username input field
                TextField("Username", text: $username)
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1))
                    .autocapitalization(.none)
                    .padding(.horizontal, 15)
                
                // Password input field
                SecureField("Password", text: $password)
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1))
                    .autocapitalization(.none)
                    .padding(.top, 40)
                    .padding(.horizontal, 15)
                
                // Login button
                Button(action: {
                    print("Login Tapped")
                    // Here you would typically check credentials
                }) {
                    HStack {
                        Text("Log in")
                            .foregroundColor(.black)
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(50)
                    .overlay(RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.white, lineWidth: 1))
                }
                .padding(.top, 80)
                .padding(.horizontal, 15)
                
                Divider()
                
                // Google login button
                Button(action: {
                    print("Google Login Tapped")
                }) {
                    HStack {
                        Image("google-logo").resizable()
                            .frame(width: 20, height: 20)
                        Text("Sign in with Google")
                            .foregroundColor(.black)
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1))
                }
                .padding(.top, 60)
                .padding(.horizontal, 15)
                
                // Sign up navigation
                HStack {
                    Text("New to LingoMates? Sign up ")
                        .font(.system(size: 20, weight: .medium))
                    
                    Button(action: {
                        // Navigate to the sign-up view
                        currentView = .signUp
                    }) {
                        Text("here")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.blue) // Link style
                    }
                }
                .padding(.top, 20)
            }
        }
        Spacer()
    }
}

#Preview {
    LoginView(currentView: .constant(.login)) // For previewing with constant binding
}
