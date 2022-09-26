//
//  RuntimeError.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation

class RuntimeError: NSError {
    
    private let message: String
    private let errCode: Int
    
    init(_ message: String, domain: String = "TestTask.RuntimeError", code: Int = -1) {
        self.message = message
        self.errCode = code
        super.init(
            domain: domain,
            code: code,
            userInfo: [
                NSLocalizedDescriptionKey: message,
                NSLocalizedFailureErrorKey: message
            ])
    }
    
    required init?(coder: NSCoder) {
        self.message = "TestTask.RuntimeError"
        self.errCode = -1
        super.init(coder: coder)
    }
    
    override var description: String {
        return self.message
    }
}
