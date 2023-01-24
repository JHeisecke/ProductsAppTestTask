//
//  APIClient.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation
import Alamofire

enum Encoding {
    case `default`
    case json
    case query
    var alamofire: ParameterEncoding {
        switch self {
        case .default:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        case .query:
            return URLEncoding.queryString
        }
    }
}

struct ApiClient {
    func request<T: Codable>(
        verb: HTTPMethod = .get,
        route: String,
        parameters: [String: Any] = [:],
        headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ],
        encoding: Encoding = .default,
        success: @escaping (T) -> Swift.Void,
        failure: ((ApiError) -> Swift.Void)? = nil
    ) {
        guard NetworkReachabilityManager()?.isReachable == true else {
            failure?(ApiError(type: .connection))
            return
        }
        BaseSessionManager.shared
            .request(route,
                     method: verb,
                     parameters: parameters,
                     encoding: encoding.alamofire,
                     headers: headers)
            .response { response in
                switch response.result {
                case .success(let data):
                    guard response.error == nil else {
                        if response.error?._code == NSURLErrorTimedOut {
                            failure?(ApiError(type: .timeout))
                        } else {
                            failure?(ApiError(type: .generic))
                        }
                        return
                    }
                    guard let data = data else {
                        failure?(ApiError())
                        return
                    }
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        success(decoded)
                    } catch let error {
                        let apiError = ApiError(message: error.localizedDescription)
                        failure?(apiError)
                    }
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 404:
                        let apiError = ApiError(type: .notFound)
                        failure?(apiError)
                    default:
                        let apiError = ApiError(message: error.localizedDescription)
                        failure?(apiError)
                    }
                }
            }
    }
}

class BaseSessionManager: Session {
    static let shared: BaseSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let manager = BaseSessionManager(configuration: configuration)
        return manager
    }()
}

