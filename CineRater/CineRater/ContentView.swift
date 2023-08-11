//
//  ContentView.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "arrow")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("This is Feature/task_1 branch")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
