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


let ourcesay = source.replacingOccurrences(
    of: "([bcdfghjklmnpqrstvwxyz]*)([a-z]+)", // 舍去 a e i o u
    with: "$2$1",
    options: [.regularExpression, .caseInsensitive])
print("ourcesay is \n \(ourcesay) \n")




let range = NSRange(location: 4, length: 5)


// Not one of these will compile:
//source[range]
//source.characters[range]
//source.substring(with: range)
//source.substring(with: range.toRange()!)

let start = String.UTF16Index(encodedOffset: range.location)

let end = String.UTF16Index(encodedOffset: range.location + range.length)

let substring = String(source.utf16[start..<end])!

print("substring is \n\(substring)")







extension String{
    
    var nsrange: NSRange{
        return NSRange(location: 0, length: utf16.count)
    }
    
    
    func substring(with nsrange: NSRange) -> String?{
        guard let range = Range(nsrange, in: self)
            else { return nil }
        return String(self[range])
    }
    
    
    func range(from nsrange: NSRange) -> Range<Index>?{
        guard let range = Range(nsrange, in: self)
            else { return nil }
        return range
    }
    
}



let miniPattern = "([*_])(.+?)\\1"
let miniFormatter = try! NSRegularExpression(pattern: miniPattern, options: .dotMatchesLineSeparators)




let text = "MiniFormatter handles *bold* and _italic_ text."
let matches2 = miniFormatter.matches(in: text, options: [], range: text.nsrange)
 print("-----------")

for match in matches2 {
    
    let matchRangeStr0 = text.substring(with: match.range(at: 0))!
    print("\n\n matchRangeStr 0 is \(matchRangeStr0)")
    
    let matchRangeStr1 = text.substring(with: match.range(at: 1))!
    print("\n\n matchRangeStr 1 is \(matchRangeStr1)")
    
    let stringToFormat = text.substring(with: match.range(at: 2))!
    print("\n\nstringToFormat is \(stringToFormat)\n")
    
   // let stringToFormat3 = text.substring(with: match.range(at: 3))!
  //  print("\n\nstringToFormat 3 is \(stringToFormat3)\n")
    switch text.substring(with: match.range(at: 1))! {
    case "*":
        print("Make bold: '\(stringToFormat)'")
    case "_":
        print("Make italic: '\(stringToFormat)'")
    default: break
    }
    print("-----------")
}




var formattedText = text
Format:
    for match in matches2.reversed() {
        let template: String
        switch text.substring(with: match.range(at: 1)) ?? "" {
            case "*":
                template = "<strong>$2</strong>"
            case "_":
                template = "<em>$2</em>"
            default: break Format
        }
        let matchRange = formattedText.range(from: match.range)!    // see above
        let replacement = miniFormatter.replacementString(for: match,
                                                          in: formattedText, offset: 0, template: template)
        formattedText.replaceSubrange(matchRange, with: replacement)
        print("\nformattedText is \n \(formattedText)")
}

print("\n")



let nameRegex = try! NSRegularExpression(pattern: "([A-Z]\\S+)\\s+([A-Z]\\S+(vitch|vna))")

public let bookString = Const().bookString
var names: Set<String> = []
var count = 0
nameRegex.enumerateMatches(in: bookString, range: bookString.nsrange) {
    (result, _, stopPointer) in
    count += 1
    guard let result = result else { return }
    let name = nameRegex.replacementString(for: result,
                                           in: bookString, offset: 0, template: "$1 $2")
    names.insert(name)
    print("第 \(count) 个 name 是 \(name)")
    // stop once we've found six unique names
    stopPointer.pointee = ObjCBool(names.count == 6)
    
}
// names.sorted():
// ["Adelaïda Ivanovna", "Alexey Fyodorovitch", "Dmitri Fyodorovitch",
//  "Fyodor Pavlovitch", "Pyotr Alexandrovitch", "Sofya Ivanovna"]

print("\n names.sorted() is \n \(names.sorted()) \n")
