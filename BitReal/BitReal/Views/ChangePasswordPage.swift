//
//  ChangePasswordPage.swift
//  BitReal
//
//  Created by Emmanuel Ihim Jr on 4/2/23.
//

// *** IN DEVELOPMENT --- PLEASE DO NOT USE ***

import SwiftUI
import Firebase
import FirebaseAuth

struct ChangePasswordPage: View {
    @State var newPassword: String = ""
    
    var body: some View {
        let user = Auth.auth().currentUser
        
        VStack {
            Spacer()
            
            Text("New Password")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 50)
            
            SecureField("Password must be > 6 characters", text: $newPassword)
                .padding()
                .background(Color.gray.opacity(0.3).cornerRadius(20))
            
            Button {
                if(newPassword != "") {
                    user?.updatePassword(to: newPassword, completion: { error in
                        if let error = error {
                            print("Error updating password: \(error.localizedDescription)")
                        } else {
                            print("Password updated successfully")
                        }
                    })
                }
            } label: {
                Text("Save")
                    .padding()
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.cornerRadius(20))
                    .foregroundColor(.white)
            }

            Spacer()
            Spacer()
        } .padding(.horizontal)
    }
}

struct ChangePasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordPage()
    }
}

