//
//  0.swift
//  regex_001
//
//  Created by dengjiangzhou on 2018/4/15.
//  Copyright © 2018年 dengjiangzhou. All rights reserved.
//

import Foundation





extension String{
    
    
    
    subscript(bounds: CountableClosedRange<Int>) -> String{
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    
    subscript(bounds: CountableRange<Int>) -> String{
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(start, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    
    
}

///////
func one(){

let miniPattern = "([*_])(.+?)\\1"
let miniFormatter = try! NSRegularExpression(pattern: miniPattern, options: .dotMatchesLineSeparators)
// the initializer throws an error if the pattern is invalid


let text = "MiniFormatter handles *bold* and _italic_ text."
let matches = miniFormatter.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))


print("matches.count is \(matches.count)")
// matches.count == 2


for match in matches{
    
   // match.range
    
    match.range(at: 0)
    
   // match.numberOfRanges
    
}

for match in matches {
  //  let rangeTwoNS = match.range(at: 2)
//    let distRangeTwoNS = rangeTwoNS.location + rangeTwoNS.length
 //   let rangeTwo = rangeTwoNS.location...distRangeTwoNS
//    let stringToFormat = text[0..<2]
    
    
    
  /*  switch text.substring(with: match.rangeAt(1))! {
    case "*":
        print("Make bold: '\(stringToFormat)'")
    case "_":
        print("Make italic: '\(stringToFormat)'")
    default: break
    }
 
 
 */
    
    
    
}
// Make bold: 'bold'
// Make italic: 'italic'


}








//          git push git@dengV:dengV/regex_001.git
