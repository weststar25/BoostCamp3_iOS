//
//  MovieListVO.swift
//  BoostCamp3iOS
//
//  Created by 김지우 on 2018. 12. 13..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

struct MovieListResult: Codable {
    let movies: [MovieListVO]
    let order_type: Int
}

struct MovieListVO: Codable {
    let reservation_rate: Double
    let id: String
    let reservation_grade: Int
    var thumb: String
    let title: String
    let user_rating: Double
    let date: String
    let grade: Int
}


