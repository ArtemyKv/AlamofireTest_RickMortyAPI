//
//  NetworkManager.swift
//  AlamofireTest
//
//  Created by Artem Kvashnin on 19.02.2023.
//

import Foundation
import Alamofire
import UIKit.UIImage


class NetworkManager {
    // MARK: - Singleton
    static let shared = NetworkManager()
    
    private init() { }
    
    // MARK: - Properties
    let baseURL: URL = URL(string: "https://rickandmortyapi.com/api")!
    
    enum Endpoints: String {
        case characters = "/character"
        case locations = "/location"
    }
    
    // MARK: - Private Methods
    private func fetchDecodable<T: Decodable>(from url: URL, parameters: [String: String]? = nil, completion: @escaping (T?, Error?) -> Void) {
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                    case .success(let result):
                        completion(result, nil)
                    case .failure(let error):
                        completion(nil, error)
                }
            }
    }
    
    private func url(endpont: Endpoints, parameters: [String: String]? = nil) -> URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.path += endpont.rawValue
        if let parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        return components.url
    }
    
    func fetchCharacters(page: Int = 1, completion: @escaping (Response?, Error?) -> Void) {
        var parameters: [String: String]?
        if page > 1 {
            parameters = ["page": "\(page)"]
        }
        guard let url = url(endpont: .characters, parameters: parameters) else { return }
        print(url)
        fetchDecodable(from: url, completion: completion)
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        AF.request(url)
            .responseData { dataResponse in
                guard let data = dataResponse.data else {
                    completion(nil)
                    return
                }
                let image = UIImage(data: data)
                completion(image)
            }
    }
    
}
