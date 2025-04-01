//
//  matchWindows.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-03-07.
//

import Foundation

func matchWindows(basename: String) -> Bool {
    
    let longPathSupport = false
    
    // Not Allowed Characters
    let forbiddenCharacters = CharacterSet(charactersIn: #"\/:*?"<>|"#)
    if basename.rangeOfCharacter(from: forbiddenCharacters) != nil {
        return false
    }
    
    // Not Allowed Reserved Names
    let reservedNames: Set<String> = [
        "CON", "PRN", "AUX", "NUL",
        "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9",
        "LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9"
    ]
    if reservedNames.contains(basename.uppercased()) {
        return false
    }
    
    // Maximum length
    var MAX_PATH:Int
    if longPathSupport {
        MAX_PATH = 260
    }
    else {
        MAX_PATH = 32767
    }
    if basename.count > MAX_PATH {
        return false
    }
    
    return true
    
    
    
    //    let pattern = #"^[\w\-. ]+$"#;
    //    if let regex = try? Regex(pattern) {
    //        return basename.wholeMatch(of: regex) != nil
    //    }
    //    return false
    //    
}
