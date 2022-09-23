//
//  String.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation

extension String {
    func toBase64Data() -> Data {
        return Data(self.utf8).base64EncodedData()
    }
}
