//
//  Endpoints.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation

struct Endpoints {
    static func host() -> String {
        return "https://fakestoreapi.com/"
    }
}

extension Endpoints {
    static func GET_products() -> String { return "\(host())/products" }
    static func GET_product(with id: String) -> String { return "\(host())/products/\(id)" }
}
