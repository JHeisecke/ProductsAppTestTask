//
//  A.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation

enum ApiErrorType: String {
    case timeout = "Timeout"
    case generic = "Generic"
    case connection = "Connection"
    case notFound = "Not Found"
    case custom = ""
}

struct ApiError: Error {
    private var type: ApiErrorType = .custom
    var code: String
    var message: String

    init(code: String = "", message: String) {
        self.message = message
        self.code = code
    }

    init (type: ApiErrorType = .custom) {
        self.message = type.rawValue
        self.code = ""
    }
}
