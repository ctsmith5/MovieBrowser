//
//  MovieModelController.swift
//  MovieBrowser
//
//  Created by Colin Smith on 5/3/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation


class MovieController: ObservableObject {
    
    static let shared = MovieController()
    
    var movies: [Movie] = []
    
    var genres: [Genre] = []
    
    func getMoviesFrom(searchTerm query: String, completion: @escaping ([Movie]) -> Void) {
        
        var urlComponents = URLComponents(string: Network.getMoviesURL)
        urlComponents?.queryItems = [URLQueryItem(name: "api_key", value: Network.apiKey),
                                     URLQueryItem(name: "language", value: "en-US"),
                                     URLQueryItem(name: "query", value: query),
                                     URLQueryItem(name: "page", value: "1"),
                                     URLQueryItem(name: "include_adult", value: "false")]
        
        guard let finalURL = urlComponents?.url?.absoluteURL else { fatalError("Error Building Movie URL")}
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = HTTPRequest.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "content")
        
        let task = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse,
                  let data = data else { return }
            
            if response.statusCode == 200 {
                
                do {
                    let movieResponse = try JSONDecoder().decode(MovieListResponse.self, from: data)
                    completion(movieResponse.results)
                } catch {
                    print("Failed to decode JSON\(error)")
                }
            }
        }
        task.resume()
    }
    
    
    func getImageFor(path: String, completion: @escaping (Data) -> Void) {
        var url = URL(string: Network.imageBasePath)
        url?.appendPathComponent(path)
        let task = URLSession(configuration: .default).dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("===========================================")
                print("200 HTTP Response, however error with Data.")
                print("===========================================")
                return
            }
            if let response = response as? HTTPURLResponse {
               if response.statusCode == 200 {
                    completion(data)
               } else {
                    print("Alert message with error message")
               }
            }
        }
        task.resume()
    }
    
    func getGenreList() {
        var urlComponents = URLComponents(string: Network.genreListURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: Network.apiKey),
            URLQueryItem(name: "language", value: "en-US")
        ]
        guard let finalURL = urlComponents?.url?.absoluteURL else { fatalError("Error Building Genre URL")}
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = HTTPRequest.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "content")
        
        let task = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse,
                  let data = data else { return }
            
            if response.statusCode == 200 {
                
                do {
                    let genreList = try JSONDecoder().decode(GenreResponse.self, from: data)
                    self.genres = genreList.genres
                } catch {
                    print("Failed to decode JSON\(error)")
                }
            }
        }
        task.resume()
    }
    
    
    func wipeOutMovieList() {
        self.movies.removeAll()
    }
}
