//
//  main.swift
//  regex_001
//
//  Created by dengjiangzhou on 2018/4/15.
//  Copyright © 2018年 dengjiangzhou. All rights reserved.
//

import Foundation

let htmlSource = "Questions? Corrections? <a href=\"https://twitter.com/NSHipster\">@NSHipster</a> or <a href=\"https://github.com/NSHipster/articles\">on GitHub</a>."

let linkRegexPattern = "<a\\s+[^>]*href=\"([^\"]*)\"[^>]*>"


let linkRegex = try! NSRegularExpression(pattern: linkRegexPattern, options: .caseInsensitive)


let matches = linkRegex.matches(in: htmlSource,  range: NSRange(location: 0, length: htmlSource.utf16.count))

let links = matches.map { result -> String in
    
    let hrefRange = result.range(at: 1)
    let start = String.UTF16Index(encodedOffset: hrefRange.location)
    
    let end = String.UTF16Index(encodedOffset: hrefRange.location + hrefRange.length)
    
    return String(htmlSource.utf16[start..<end])!
    
}

print("links: \n \(links)\n\n")


// MARK: - 第二段


let source = "For NSSet and NSDictionary, the breaking..."

// Matches anything that looks like a Cocoa type:
// UIButton, NSCharacterSet, NSURLSession, etc.
let typePattern = "[A-Z]{3,}[A-Za-z0-9]+"

if let typeRange = source.range(of: typePattern,
                                options: .regularExpression) {
    print("\n First type: \(source[typeRange]) \n")
    // First type: NSSet
}


let markedUpSource = source.replacingOccurrences(of: typePattern, with: "'$0'", options: .regularExpression)

print( "\nmarkedUpSource is \(markedUpSource) \n" )



