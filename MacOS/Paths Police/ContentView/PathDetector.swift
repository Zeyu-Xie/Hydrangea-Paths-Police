//
//  PathDetector.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-02-27.
//

import SwiftUI

struct PathDetector: View {
    
    @State private var selectedFilePath: String?
    
    var body: some View {
        VStack {
            Text("Selected File Path: " + (selectedFilePath ?? ""))
            Button(action: selectFile) {
                Text("Select File or Folder")
            }
        }
    }
    
    func selectFile() {
        let panel = NSOpenPanel()
        panel.title = "Select File or Folder"
        panel.allowedContentTypes = [] // All Type Supported
        panel.allowsMultipleSelection = false // One File Limited
        panel.canChooseDirectories = true // Folder Allowed
        if panel.runModal() == .OK {
            selectedFilePath = panel.url?.path // Get Selected Path
            let allFilesAndFolders = getAllFilesAndFolders(at: selectedFilePath!)
            for item in allFilesAndFolders {
                print(type(of: item))
                print(item)
            }
        }
        
    }
    
    func getAllFilesAndFolders(at path: String) -> [String] {
        let fileManager = FileManager.default
        var allItems: [String] = []
        
        do {
            let items = try fileManager.contentsOfDirectory(
                atPath: path
            ) // 获取当前目录下的内容
            for item in items {
                let fullPath = (path as NSString).appendingPathComponent(
                    item
                ) // 绝对路径
                allItems.append(fullPath)
                
                var isDir: ObjCBool = false
                if fileManager
                    .fileExists(atPath: fullPath, isDirectory: &isDir), isDir.boolValue {
                    let subItems = getAllFilesAndFolders(
                        at: fullPath
                    ) // 递归获取子目录
                    allItems.append(contentsOf: subItems)
                }
            }
        } catch {
            print("读取目录失败: \(error.localizedDescription)")
        }
        
        return allItems
    }
}
