//
//  ChangeUsernamePage.swift
//  BitReal
//
//  Created by Emmanuel Ihim Jr on 4/2/23.
//

// *** IN DEVELOPMENT --- PLEASE DO NOT USE ***

import SwiftUI
import Firebase
import FirebaseAuth

struct ChangeUsernamePage: View {
    
    @State var newUsername: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        let db = Firestore.firestore()
        let ref = db.collection("users")
        let user = Auth.auth().currentUser
        let userID = user?.uid
        
        VStack {
            Spacer()
            
            Text("New Username")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 50)
            
            TextField("Enter New Username", text: $newUsername)
                .padding()
                .background(Color.gray.opacity(0.3).cornerRadius(20))
            
            Button {
                if(newUsername != "") {
                    ref.document(userID!).updateData(["username": newUsername]) { error in
                        if let error = error {
                            print("Error updating username: \(error.localizedDescription)")
                        } else {
                            viewModel.fetchUser()
                            print("Username updated successfully")
                        }
                    }
                }
            } label: {
                Text("Save")
                    .padding()
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .background(Color("Purple").cornerRadius(20))
                    .foregroundColor(.white)
            }

            Spacer()
            Spacer()
        } .padding(.horizontal)
    }
}

struct ChangeUsernamePage_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUsernamePage()
    }
}

