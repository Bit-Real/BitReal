//
//  Experiments.swift
//  BitReal
//
//  Created by Emmanuel Ihim Jr on 4/16/23.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 5)
            VStack(alignment: .leading) {
                Text("Card Title")
                    .font(.headline)
                    .padding(.bottom, 5)
                Text("Card Description")
                    .font(.subheadline)
                Spacer()
            }
            .padding()
        }
        .frame(height: 100)
        .padding(.horizontal)
    }
}


struct Experiments: View {
    var body: some View {
        List {
            CardView()
                .listRowSeparator(.hidden)
            CardView()
                .listRowSeparator(.hidden)
            CardView()
                .listRowSeparator(.hidden)
        } .listStyle(PlainListStyle())
    }
}

struct Experiments_Previews: PreviewProvider {
    static var previews: some View {
        Experiments()
    }
}
