//
//  MovieListInfoService.swift
//  BC3iOS
//
//  Created by 김지우 on 2018. 12. 15..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

class BoxOfficeService {
    typealias QueryResult = ([MovieListVO], String) -> ()
    
    var movies: [MovieListVO] = []
    var errorMessage = ""
    
    let baseURL = "http://connect-boxoffice.run.goorm.io"
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getMovieList(orderType: Int, onTableList: @escaping QueryResult) {
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
}
