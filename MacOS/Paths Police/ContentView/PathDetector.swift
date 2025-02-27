//
//  PathDetector.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-02-27.
//

import SwiftUI

struct PathDetector: View {
    
    @State private var showFullPath: Bool = false
    @State private var selectedPath: String?
    @State private var allPaths: [String] = []
    @State private var displayPath: String?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: selectFile) {
                    Text("Select File or Folder")
                }
                Button(action: {
                    showFullPath = !showFullPath
                }) {
                    Text(showFullPath ? "Hide Full Path" : "Show Full Path")
                }
                Spacer()
                Text(selectedPath ?? "Please Select a File or Folder")
            }
            .padding(.horizontal)
            .padding(.top)
            Divider()
                .padding()
            HStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(allPaths, id: \.self) { path in
                            Button(action: {
                                displayPath = path
                            }) {
                                showFullPath ? Text(path) : Text(
                                    URL(fileURLWithPath: path).lastPathComponent
                                )
                            }
                            .buttonStyle(LinkButtonStyle())
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                VStack {
                    if let displayPath = displayPath {
                        Text("Type: \(isDir(atPath: displayPath)! ? "Folder" : "File")")
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
    
    func selectFile() {
        let panel = NSOpenPanel()
        panel.title = "Select File or Folder"
        panel.allowedContentTypes = [] // All Type Supported
        panel.allowsMultipleSelection = false // One File Limited
        panel.canChooseDirectories = true // Folder Allowed
        if panel.runModal() == .OK {
            selectedPath = panel.url?.path
            if isDir(atPath: selectedPath!)! {
                allPaths = getAllFilesAndFolders(at: selectedPath!)
            }
            else {
                allPaths = [selectedPath!]
            }
        }
    }
    
    func getAllFilesAndFolders(at path: String) -> [String] {
        let fileManager = FileManager.default
        var allItems: [String] = []
        
        do {
            let items = try fileManager.contentsOfDirectory(
                atPath: path
            )
            for item in items {
                let fullPath = (path as NSString).appendingPathComponent(
                    item
                )
                allItems.append(fullPath)
                
                var isDir: ObjCBool = false
                if fileManager
                    .fileExists(atPath: fullPath, isDirectory: &isDir), isDir.boolValue {
                    let subItems = getAllFilesAndFolders(
                        at: fullPath
                    )
                    allItems.append(contentsOf: subItems)
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return allItems
    }
}
