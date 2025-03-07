//
//  matchWindows.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-03-07.
//

func matchWindows(basename: String) -> Bool {
    
    let pattern = #"^[\w\-. ]+$"#;
    if let regex = try? Regex(pattern) {
        return basename.wholeMatch(of: regex) != nil
    }
    return false
    
}
