//
//  SourceEditorCommand.swift
//  Chris Convert to Literals
//
//  Created by songjian on 2018/9/26.
//  Copyright © 2018 Jian Soung's Studio. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        var updatedLineIndexes = [Int]()

        for lineIndex in 0 ..< invocation.buffer.lines.count {
            let originalLine = invocation.buffer.lines[lineIndex] as! String
            let literalMapping = [
                "UIColor(": "#colorLiteral(",
                "UIImage(named:": "#imageLiteral(resourceName:"
            ]

            var newLine = originalLine
            for (old, new) in literalMapping {
                newLine = newLine.replacingOccurrences(of: old, with: new)
            }

            if originalLine != newLine {
                updatedLineIndexes.append(lineIndex)
                invocation.buffer.lines[lineIndex] = newLine
            }
        }

        // Select all lines that received replacements

        let updatedSelections: [XCSourceTextRange] = updatedLineIndexes.map { lineIndex in
            let lineSelection = XCSourceTextRange()
            lineSelection.start = XCSourceTextPosition(line: lineIndex, column: 0)
            lineSelection.end = XCSourceTextPosition(line: lineIndex + 1, column: 0)
            return lineSelection
        }

        invocation.buffer.selections.setArray(updatedSelections)

        // Finish the command

        completionHandler(nil)
    }
    
}
