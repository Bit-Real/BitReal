//
//  RegisterIView.swift
//  BitReal
//
//  Created by Pinru Chen on 2/27/23.
//

import SwiftUI

struct RegisterIView: View {
    
    @State private var email = ""
    @State private var registerSuccess = false
    @State private var showAlert = false
    @State private var navigationActive = false
    
    var body: some View {
        VStack {
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
            
            Button {
                if Utility.isValidEmail(email) {
                    navigationActive = true
                } else {
                    showAlert = true
                }
            } label: {
                Text("Continue")
                    .frame(width: 160, height: 50)
                    .foregroundColor(.white)
                    .background(Color("Purple"))
                    .cornerRadius(10)
            }
            .offset(y: -200)
            .background(NavigationLink("", destination: RegisterInfoView(email: email), isActive: $navigationActive))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Email Address"),
                      message: Text("Please enter a valid email address."),
                      dismissButton: .default(Text("OK")))
            }

            Text("By signing up, you agree to BitReal’s Terms of Service and Privacy Policy.")
                .frame(alignment: .center)
                .font(.system(size: 13))
                .padding(.top, 50)
                .offset(y: -225)
        }
    }

}

struct RegisterIView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterIView()
    }
}
