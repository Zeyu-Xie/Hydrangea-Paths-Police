//
//  PathDetector.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-02-27.
//

import SwiftUI
import AppKit

struct PathDetector: View {
    
    // User Config
    @State private var showFullPath: Bool = false
    @State private var showOnlyProblematicItems: Bool = false
    
    // Status Variables
    @State private var selectedPath: String?
    @State private var allPaths: [String] = []
    @State private var displayPath: String?
    
    var body: some View {
        
        VStack {
            
            // Top Buttons
            HStack {
                Button(action: selectFile) {
                    Text("Select File or Folder")
                }
                Button(action: {
                    refresh()
                }) {
                    Text("Refresh")
                }
                Spacer()
                Text(selectedPath ?? "Please Select a File or Folder")
                if let selectedPath = selectedPath {
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(selectedPath, forType: .string)
                    }) {
                        Image(systemName: "document.on.document")
                    }
                    .buttonStyle(LinkButtonStyle())
                }
            }
            
            Divider()
                .padding(.vertical, 6)
            
            // Functional Panels
            HStack {
                
                // Left
                VStack {
                    if selectedPath != nil {
                        
                        // Statistics Panel
                        HStack {
                            StatisticsPanel(allPaths: $allPaths)
                            Spacer()
                        }
                        
                        Divider()
                            .padding(.vertical, 6)
                        
                        // File List Panel
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(allPaths, id: \.self) { path in
                                    if(
                                        matchWindows(
                                            basename: basename(atPath: path)
                                        )
                                    ) {
                                        if (!showOnlyProblematicItems) {
                                            HStack {
                                                Button(action: {
                                                    displayPath = path
                                                }) {
                                                    showFullPath ? Text(path) : Text(
                                                        basename(atPath: path)
                                                    )
                                                }
                                                .buttonStyle(LinkButtonStyle())
                                                Spacer()
                                                Text("✅")
                                            }
                                        }
                                    }
                                    else {
                                        HStack {
                                            Button(action: {
                                                displayPath = path
                                            }) {
                                                showFullPath ? Text(path) : Text(
                                                    basename(atPath: path)
                                                )
                                            }
                                            .buttonStyle(LinkButtonStyle())
                                            Spacer()
                                            Text("❌")
                                        }
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                            .padding(.vertical, 6)
                        
                        // Left Bottom Buttons
                        HStack {
                            Button(action: {
                                showOnlyProblematicItems = !showOnlyProblematicItems
                            }) {
                                Text(
                                    showOnlyProblematicItems ? "Show all Items" : "Show only Problematic Items"
                                )
                            }
                            Button(action: {
                                showFullPath = !showFullPath
                            }) {
                                Text(showFullPath ? "Hide Full Path" : "Show Full Path")
                            }
                            Spacer()
                        }
                    }
                }
                
                // Right
                VStack {
                    if let displayPath {
                        InfoPanel(displayPath: Binding(
                            get: { displayPath },
                            set: { newValue in self.displayPath = newValue }
                        ))
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.leading)
            }
        }
        .padding()
    }
    
    func selectFile() {
        let panel = NSOpenPanel()
        panel.title = "Select File or Folder"
        panel.allowedContentTypes = []
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
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
    
    func refresh() {
        if selectedPath != nil {
            allPaths = getAllFilesAndFolders(at: selectedPath!)
            displayPath = nil
        }
    }
}

struct StatisticsPanel: View {
    
    @Binding var allPaths: [String]
    
    var body: some View {
        HStack {
            Text("\(allPaths.count)")
                .bold()
            Text("items scanned,")
            Text("\(problemCnt())")
                .bold()
                .foregroundStyle(.red)
            Text("problematic items detected.")
        }
    }
    
    func problemCnt() -> Int {
        var cnt = 0
        for path in allPaths {
            if !matchWindows(basename: basename(atPath: path)) {
                cnt += 1
            }
        }
        return cnt
    }
}

struct InfoPanel: View {
    
    @Binding var displayPath: String
    
    var body: some View {
        let items = [
            ("Type", pathType(atPath: displayPath)),
            ("Name", basename(atPath: displayPath)),
            ("Path", displayPath),
            (
                "Match Windows",
                matchWindows(
                    basename: basename(atPath: displayPath)
                ) ? "True" : "False"
            )
        ]

        VStack {
            VStack {
                ForEach(
                    Array(items.enumerated()),
                    id: \.element.0
                ) {
                    index,
                    item in
                    let (label, value) = item
                    HStack {
                        Text(label)
                            .bold()
                        Spacer()
                        Text(value)
                    }
                    .padding(
                        .bottom,
                        index == items.count - 1 ? 0 : 6
                    )
                }
            }
            .frame(maxWidth: .infinity)
            VStack {
                Button(action: {
                    showInFinder()
                }) {
                    Text("Show in Finder")
                }
            }
            .padding(.top, 6)
        }
    }
    
    func showInFinder() {
        let url = URL(fileURLWithPath: displayPath)
        NSWorkspace.shared.activateFileViewerSelecting([url])
    }
}
