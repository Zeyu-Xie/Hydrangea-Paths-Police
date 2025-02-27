//
//  ContentView.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-02-27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Functions")) {
                    NavigationLink(destination: PathDetector()) {
                        Text("Detect Path")
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .padding(.vertical)
        }
        
    }
}
