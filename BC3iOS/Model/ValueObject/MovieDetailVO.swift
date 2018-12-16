//
//  MovieDetailVO.swift
//  BoostCamp3iOS
//
//  Created by 김지우 on 2018. 12. 13..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

struct MovieDetailVO: Codable {
    let audience: Int
    let grade: Int
    let actor: String?
    let duration: Int
    let reservation_grade: Int
    let title: String?
    let reservation_rate: Double
    let user_rating: Double
    let date: String?
    let director: String?
    let id: String?
    let image: String?
    let synopsis: String?
    let genre: String?
}

struct MovieDetailCommentVO: Codable {
    let rating: Int
    let timestamp: Double
    let writer: String?
    let movie_id: String?
    let contents: String?
}
