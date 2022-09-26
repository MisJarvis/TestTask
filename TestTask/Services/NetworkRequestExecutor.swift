//
//  NetworkRequestExecutor.swift
//  TestTask
//
//  Created by Yevstafieva Yevheniia on 23.09.2022.
//

import Foundation
import Alamofire
import Combine
import SwiftJWT

final class NetworkRequestExecutor {
    static let network: Session = Session.default
    let network: Session
    let baseURLString: String
    
    init(
        network: Session? = nil,
        baseURLString: String = "https://opn-interview-service.nn.r.appspot.com"
    ) {
        if let network = network {
            self.network = network
        } else {
            self.network = Self.network
        }
        self.baseURLString = baseURLString
    }
    
    private func getJWTToken() -> String {
        do {
            let claims = JWTClaims(uid: UUID(), identity: "Yevstafieva Yevheniia")
            var jwt = JWT(claims: claims)
            
            let token = try jwt.sign(using: .hs256(key: "$SECRET$".toBase64Data()))
            return token
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func executeRequest<T: Codable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default
    ) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            let urlString = self.baseURLString + path
            
            let requestId = NSUUID().uuidString
            
            let token = self.getJWTToken()
            
            let headers = HTTPHeaders([
                "request-id": requestId,
                "Authorization": "Bearer \(token)"
            ])
            
            let mutatingHeaders = headers
            
            self.executeRequest(
                urlString: urlString,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: mutatingHeaders,
                completion: promise
            )
        }
        .eraseToAnyPublisher()
    }
    
    private func executeRequest<T: Codable>(
        urlString: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        network.request(
            urlString,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        ).responseDecodable(
            of: T.self,
            completionHandler: { result in
                if let error = result.error {
                    completion(.failure(error))
                } else if let value = result.value {
                    completion(.success(value))
                }
            })
    }
}
