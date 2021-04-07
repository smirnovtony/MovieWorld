//
//  MWTopRatedResponse.swift
//  MovieWorld
//
//  Created by Антон Смирнов on 7.04.21.
//

import Foundation

struct MWTopRatedResponse: Decodable {
    let page: Int
    let results: [MWMovie]
    let total_results: Int
    let total_pages: Int
}
