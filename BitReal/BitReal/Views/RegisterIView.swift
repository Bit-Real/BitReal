//
//  RegisterIView.swift
//  BitReal
//
//  Created by Pinru Chen on 2/27/23.
//

import SwiftUI
import Firebase

struct RegisterIView: View {
    @State private var email = ""
    @State private var registerSuccess = false
    @State private var errorMessage = ""

    var body: some View {
        VStack{
            Text("Register")
                .padding(.top, 50)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .offset(x: -90, y: -200)

            TextField("Email Address", text: $email)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .offset(y: -235)
                .padding(.top, 30)

            Button(action: {
                if isValidEmail(email) {
                    registerWithEmail()
                } else {
                    self.errorMessage = "Please enter a valid email address."
                    self.registerSuccess = true
                }
            }) {
                CustomButton(color: .white, outline: true, label: "Continue")
            }
            .offset(y: -200)
            .alert(isPresented: Binding<Bool>(
                get: { self.registerSuccess },
                set: { self.registerSuccess = $0 }
            )) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }

            Text("By signing up, you agree to BitReal’s Terms of Service and Privacy Policy.")
                .frame(alignment: .center)
                .font(.system(size: 13))
                .padding(.top, 50)
                .offset(y: -225)
        }
    }

    private func registerWithEmail() {
        Auth.auth().fetchSignInMethods(forEmail: email) { (methods, error) in
            if let error = error {
                // Handle the error
                self.errorMessage = "An error occurred while checking if the email address is registered. Please try again later."
                self.registerSuccess = true
                print("Error fetching sign-in methods: \(error.localizedDescription)")
            } else if let methods = methods {
                if methods.isEmpty {
                    // The email address is not registered with Firebase authentication
                    self.registerSuccess = false
                    // Navigate to RegisterInfoView to continue with registration
                    NavigationLink(destination: RegisterInfoView(email: email)) {
//                        EmptyView()
                    }
                } else {
                    // The email address is already registered with Firebase authentication
                    self.errorMessage = "This email address is already registered. Please use a different email address or sign in."
                    self.registerSuccess = true
                }
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        // Regular expression for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct RegisterIView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterIView()
    }
}
