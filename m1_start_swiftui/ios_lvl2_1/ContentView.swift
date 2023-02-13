//
//  ContentView.swift
//  ios_lvl2_1
//
//  Created by i0240 on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var opacity: Double = 0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("Илья")
            .opacity(opacity)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 3)) {
                    opacity = 1
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
