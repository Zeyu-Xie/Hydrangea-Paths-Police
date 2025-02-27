//
//  isDir.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-02-27.
//

import Foundation

func isDir(atPath path: String) -> Bool? {
    var isDirectory: ObjCBool = false
    let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
    if exists {
        return isDirectory.boolValue
    } else {
        return nil
    }
}
