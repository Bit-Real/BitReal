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
            
            NavigationLink(destination: RegisterInfoView()) {
                CustomButton(color: .white, outline: true, label: "Log In")
            }
            .offset(y: -200)

            Text("By signing up, you agree to BitReal’s Terms of Service and Privacy Policy.")
                .frame(alignment: .center)
                .font(.system(size: 13))
                .padding(.top, 50)
                .offset(y: -225)
            
//            Button(action: {if email == "Longhorn@utexas.edu"{
//                registerSuccess = true
//            }}){
//                Text("SIGN UP")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(width: 300, height: 50)
//                    .background(Color("Purple"))
//                    .cornerRadius(10)
//                    .offset(y: -260)
//            }
//            VStack{
//                Text("By signing up, you agree to BitReal’s Terms of Service and Privacy Policy.")
//                    .frame(alignment: .center)
//                    .font(.system(size: 13))
//                    .offset(y: -235)
//            }
        }
    }
}

struct RegisterIView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterIView()
    }
}
