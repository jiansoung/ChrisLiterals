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
        
        completionHandler(nil)
    }
    
}
