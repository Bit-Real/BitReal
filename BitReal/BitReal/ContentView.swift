//
//  ContentView.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/22/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                SplashView()
            } else {
                Navbar()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
