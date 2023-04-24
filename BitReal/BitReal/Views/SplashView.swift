//
//  SplashView.swift
//  BitReal
//
//  Created by Pinru Chen on 2/26/23.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("splashImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack{
                    Text("BitReal")
                        .font(.system(size: 55))
                        .offset(x:50, y:30)
                    
                    Image("logoImage")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .offset(x: -90, y: -70)
                    
                    HStack {
                        NavigationLink(destination: LoginPage()) {
                            CustomButton(color: Color("Purple"), outline: false, label: "LOGIN")
                            
                        }
                        NavigationLink(destination: RegisterIView()) {
                            CustomButton(color: .white, outline: true, label: "REGISTER")
                        }
                    }
                    .offset(x: 0, y: 250)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
