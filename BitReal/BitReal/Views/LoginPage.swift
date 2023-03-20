//
//  LoginPage.swift
//  BitReal
//
//  Created by Pinru Chen on 2/27/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginPage: View {
    @State private var userName = ""
    @State private var password = ""
    @State private var loginSuccess = false
    
    var body: some View {
        VStack{
            Text("Log in")
                .padding(.top, 50)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .offset(x: -100, y: -200)
            
            TextField("Username", text: $userName)
                .padding()
                .frame(width: 300)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .offset(y: -220)
                .padding(.top, 30)
            
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 300)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .offset(y: -220)
                .padding(.top, 20)
            
            Button(action: {
                Auth.auth().signIn(withEmail: userName, password: password) { (result, error) in
                    if let error = error as NSError? {
                        // self.statusMessage.text = "\(error.localizedDescription)"
                        print("\(error.localizedDescription)")
                    } else {
                        loginSuccess = true
                    }
                }
            }) {
                NavigationLink(destination: Navbar()) {
                    CustomButton(color: .white, outline: true, label: "Log In")
                }
                .disabled(!loginSuccess)
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
