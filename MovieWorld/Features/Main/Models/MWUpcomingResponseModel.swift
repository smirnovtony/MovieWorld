//
//  MWUpcomingResponseModel.swift
//  MovieWorld
//
//  Created by Антон Смирнов on 5.04.21.
//

import Foundation

struct MWUpcomingResponseModel: Decodable {
    let page: Int
    let results: [MWMovie]
    let total_results: Int
    let total_pages: Int
}
