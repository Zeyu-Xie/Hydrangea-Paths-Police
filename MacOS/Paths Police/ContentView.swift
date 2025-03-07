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
                Section(header: Text("App Info")) {
                    NavigationLink(destination: PrivacyPolicy()) {
                        Text("Privacy Policy")
                    }
                    NavigationLink(destination: About()) {
                        Text("About")
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .padding(.vertical)
        }
        
    }
}
