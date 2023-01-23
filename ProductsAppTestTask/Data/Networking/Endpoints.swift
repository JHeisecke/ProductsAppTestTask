//
//  Endpoints.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation

struct Endpoints {
    func host() -> String {
        return "https://fakestoreapi.com/"
    }
}

extension Endpoints {
    func GET_products() -> String { return "\(host())/products" }
    func GET_product(with id: String) -> String { return "\(host())/products/\(id)" }
}
