//
//  Util.swift
//  BanqueMisr-demoApp
//
//  Created by Vladimir Stasenko on 04.02.2024.
//

import Foundation

struct URLConstructor {
    
    enum Params: String {
        case page
        case sortBy = "sort_by"
    }
    
    static func addParams(to path: String,
                          addToPath: String = "",
                          params: [Params: String] = [:]) -> URL? {
        var newPath = path
        newPath.append(addToPath)
        
        params.forEach {
            if let last = newPath.last,
               String(last) != "?" {
                // Need to add the separator
                newPath.append("&")
            }
            newPath.append("\($0.key.rawValue)=\($0.value)")
        }
        
        return URL(string: newPath)
    }
}
