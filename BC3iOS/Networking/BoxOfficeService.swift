//
//  MovieListInfoService.swift
//  BC3iOS
//
//  Created by 김지우 on 2018. 12. 15..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

class BoxOfficeService {
    typealias GetMovieListResult = ([MovieListVO], String) -> ()
    typealias GetMovieInfoResult = (MovieDetailVO, String) -> ()
    typealias GetCommentsResult = ([MovieDetailCommentVO], String) -> ()
    typealias GetMovieTotalInfoResult = (MovieDetailVO, [MovieDetailCommentVO], String) -> ()
    
    var movies: [MovieListVO] = []
    var movieInfo: MovieDetailVO?
    var movieComments: [MovieDetailCommentVO] = []
    var errorMessage = ""
    
    let baseURL = "http://connect-boxoffice.run.goorm.io"
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getMovieList(orderType: Int, onTableList: @escaping GetMovieListResult) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: baseURL+"/movies") {
            urlComponents.query = "order_type=\(orderType)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self.updateMovieListResults(data)
                    DispatchQueue.main.async { onTableList(self.movies, self.errorMessage) }
                }
            }
            dataTask?.resume()
        }
    }
    
    fileprivate func updateMovieListResults(_ data: Data) {
        let decoder = JSONDecoder()
        self.movies.removeAll()
        do {
            let movieListInfoResult = try decoder.decode(MovieListResult.self, from: data)
            self.movies = movieListInfoResult.movies
        } catch let err as NSError {
            self.errorMessage += "JSONDecoder error: \(err.localizedDescription)\n"
            return
        }
    }
    
    func getMovieInfo(movieID: String, onMovieInfo: @escaping GetMovieInfoResult) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: baseURL+"/movie") {
            urlComponents.query = "id=\(movieID)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self.updateMovieInfoResults(data)
                    guard let movieInfo = self.movieInfo else { return }
                    DispatchQueue.main.async { onMovieInfo(movieInfo, self.errorMessage) }
                }
            }
            dataTask?.resume()
        }
    }
    
    func getMovieInfo(movieID: String, onMovieTotalInfo: @escaping GetMovieTotalInfoResult) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: baseURL+"/movie") {
            urlComponents.query = "id=\(movieID)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self.updateMovieInfoResults(data)
                    self.getMovieComment(movieID: movieID, onMovieTotalInfo: onMovieTotalInfo)
                    print("movieID = \(movieID)")
                }
            }
            dataTask?.resume()
        }
    }
    
    fileprivate func updateMovieInfoResults(_ data: Data) {
        let decoder = JSONDecoder()
        self.movieInfo = nil
        do {
            let movieInfoResult = try decoder.decode(MovieDetailVO.self, from: data)
            self.movieInfo = movieInfoResult
        } catch let err as NSError {
            self.errorMessage += "JSONDecoder error: \(err.localizedDescription)\n"
            return
        }
    }
    
    func getMovieComment(movieID: String, onMovieComments: @escaping GetCommentsResult) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: baseURL+"/comments") {
            urlComponents.query = "movie_id=\(movieID)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self.updateMovieCommentsResults(data)
                    DispatchQueue.main.async { onMovieComments(self.movieComments, self.errorMessage) }
                }
            }
            dataTask?.resume()
        }
    }
    
    func getMovieComment(movieID: String, onMovieTotalInfo: @escaping GetMovieTotalInfoResult) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: baseURL+"/comments") {
            urlComponents.query = "movie_id=\(movieID)"
            guard let url = urlComponents.url else { return }
            print("comments = \(url)")
            dataTask = defaultSession.dataTask(with: url) { data, response, error in defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self.updateMovieCommentsResults(data)
                    guard let movieInfo = self.movieInfo else { return }
                    DispatchQueue.main.async { onMovieTotalInfo(movieInfo, self.movieComments, self.errorMessage) }
                }
            }
            dataTask?.resume()
        }
    }
    
    fileprivate func updateMovieCommentsResults(_ data: Data) {
        let decoder = JSONDecoder()
        self.movieComments.removeAll()
        do {
            let movieCommentsResult = try decoder.decode(MovieDetailCommentResult.self, from: data)
            self.movieComments = movieCommentsResult.comments
        } catch let err as NSError {
            self.errorMessage += "JSONDecoder error: \(err.localizedDescription)\n"
            return
        }
    }
    
    
}
