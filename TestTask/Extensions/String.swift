//
//  String.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation

// MARK: String to base64EncodedData

extension String {
    func toBase64Data() -> Data {
        return Data(self.utf8).base64EncodedData()
    }
}

// MARK: Localizable

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    func localizedWithVars(vars: CVarArg...) -> String {
        return String(
            format: localized,
            arguments: vars
        )
    }
}
