//
//  pathType.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-02-28.
//

import Foundation

func pathType(atPath path: String) -> String {
    let id = isDir(atPath: path)
    if let id = id {
        return id ? "Folder" : "File"
    }
    else {
        return "Path Error"
    }
}
