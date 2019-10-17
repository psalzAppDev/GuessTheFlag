//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Peter Salz on 17.10.19.
//  Copyright © 2019 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            
            ZStack {
                Color.red.edgesIgnoringSafeArea(.all)
                Text("Your Content")
            }
            .background(Color.red)
            
            Button(action: {
                print("Edit button was tapped")
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                    Text("Edit")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
