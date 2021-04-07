//
//  Url+Ex.swift
//  MovieWorld
//
//  Created by Антон Смирнов on 5.04.21.
//

import Foundation

extension URL {
init?(urlString: String, path: String = "", params: [String: String]? = nil) {
        guard var components = URLComponents(string: urlString + path) else { return nil }
        if let params = params {
            components.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
        }
        guard let url = components.url else { return nil }
        self = url
    }
}

