//
//  basename.swift
//  Paths Police
//
//  Created by Zeyu Xie on 2025-02-28.
//

import Foundation

func basename(atPath path: String) -> String {
    return URL(fileURLWithPath: path).lastPathComponent
}
