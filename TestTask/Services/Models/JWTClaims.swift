//
//  JWTClaims.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 26.09.2022.
//

import Foundation
import SwiftJWT

struct JWTClaims: Claims {
    let uid: UUID
    let identity: String
}
