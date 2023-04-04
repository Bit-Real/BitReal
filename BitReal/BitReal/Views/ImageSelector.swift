//
//  ImageSelector.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/3/23.
//

import SwiftUI

struct ImageSelector: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var randomSelected = false
    var email: String
    var username: String
    var fullName: String
    var password: String
    var confirmPassword: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack { Spacer() }
                
                Text("Select a profile")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("picture...")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height: 260)
            .padding(.leading)
            .background(Color("Purple"))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            Button {
                // call image selector
                print("Uploading pic button presed...")
            } label: {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 3, dash: [12]))
                    .frame(width: 250, height: 250)
                    .foregroundColor(Color("Purple"))
                    .overlay(
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("Purple"))
                    )
                    .padding(.top, 50)
            }
            
            Toggle("Select a photo for me", isOn: $randomSelected)
                .toggleStyle(SwitchToggleStyle(tint: Color(.systemPurple)))
                .padding()
                .padding(.top, 30)
            
            Button {
                authViewModel.signup(withEmail: self.email,
                                     password: self.password,
                                     confirmPassword: self.confirmPassword,
                                     fullname: self.fullName,
                                     username: self.username)
            } label: {
                NavigationLink(destination: Navbar()) {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .frame(width: 180, height: 50)
                        .background(Color("Purple"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct ImageSelector_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelector(email: "", username: "", fullName: "", password: "", confirmPassword: "")
    }
}
