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
                    
                    NavigationLink(destination: LoginPage()) {
                        Text("LOG IN")
                            .frame(width: 160, height: 50)
                            .foregroundColor(.purple)
                            .background(Color.white)
                            .cornerRadius(10)
                            .offset(CGSize(width: -88, height: 268))
                        
                    }
                    NavigationLink(destination: RegisterIView()) {
                        Text("REGISTER")
                            .frame(width: 160, height: 50)
                            .foregroundColor(.white)
                            .background(Color.purple)
                            .cornerRadius(10)
                            .offset(CGSize(width: 88, height: 210))
                    }
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
