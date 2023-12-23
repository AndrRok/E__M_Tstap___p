//
//  NetworkManager.swift
//  EMTstapp
//
//  Created by ARMBP on 12/20/23.
//

import UIKit

final class NetworkManager: ObservableObject {
    let cache = NSCache<NSString, UIImage>()
    private let mainURL = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
    private let deteilsURL = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
    private let bookURL =  "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
    
    func getMainRequest(completed: @escaping (Result<Hotel, ErrorMessages>) -> Void) {
        let endpoint = mainURL
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                let itemResult            = try decoder.decode(Hotel.self, from: data)
                completed(.success(itemResult))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getDetails(completed: @escaping (Result<Rooms, ErrorMessages>) -> Void) {
        let endpoint = deteilsURL
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                let detailResult        = try decoder.decode(Rooms.self, from: data)
                completed(.success(detailResult))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getBook(completed: @escaping (Result<BookModel, ErrorMessages>) -> Void) {
        let endpoint = bookURL
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                let bookResult        = try decoder.decode(BookModel.self, from: data)
                completed(.success(bookResult))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
