//
//  ChangeUsernamePage.swift
//  BitReal
//
//  Created by Emmanuel Ihim Jr on 4/2/23.
//

import SwiftUI

struct ChangeUsernamePage: View {
    @State var newUsername: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("New Username")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 50)
            
            TextField("Enter New Username", text: $newUsername)
                .padding()
                .background(Color.gray.opacity(0.3).cornerRadius(20))
            
            Button {
                // update username
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

struct ChangeUsernamePage_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUsernamePage()
    }
}

