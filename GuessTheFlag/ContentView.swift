//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Peter Salz on 17.10.19.
//  Copyright © 2019 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack {
            
            ZStack {
                Color.red.edgesIgnoringSafeArea(.all)
                Text("Your Content")
            }
            .background(Color.red)
            
            Button(action: {
                self.showingAlert = true
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                    Text("Show Alert")
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Hello SwiftUI!"),
                      message: Text("This is some detail message"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
