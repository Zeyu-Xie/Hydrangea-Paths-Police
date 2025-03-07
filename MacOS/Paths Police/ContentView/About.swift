//
//  About.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-03-07.
//

import SwiftUI

struct About: View {
    var body: some View {
        VStack(spacing: 10) {
            Text(getAppName())
                .font(.title2)
                .bold()
            
            Text("Bundle ID: \(getBundleID())")
                .font(.body)
                .foregroundColor(.secondary)
            
            Divider()
            
            Text("Version \(getAppVersion()) (Build \(getBuildVersion()))")
                .font(.body)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: 300)
        .padding()
    }
}

extension Bundle {
    var appName: String {
        infoDictionary?["CFBundleName"] as? String ?? "Unknown"
    }
    
    var bundleID: String {
        bundleIdentifier ?? "Unknown"
    }
    
    var appVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    var buildVersion: String {
        infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }
}

// 获取 App 信息的方法
func getAppName() -> String { Bundle.main.appName }
func getBundleID() -> String { Bundle.main.bundleID }
func getAppVersion() -> String { Bundle.main.appVersion }
func getBuildVersion() -> String { Bundle.main.buildVersion }

