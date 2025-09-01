//
//  ApiService.swift
//  Pokemons
//
//  Created by tunc on 15.07.2025.
//

import Foundation
import RxSwift

enum APIEndpoint {
  case getPokemons(offset: Int, limit: Int, pageNumber: Int)
  case getPokemonDetails(id: Int)
  case getPokemonSpecies(id: Int)
  
  var url: URL? {
    let baseURL = "https://pokeapi.co/api/v2/"
    
    switch self {
    case .getPokemons(let offset, let limit, let pageNumber):
      return URL(string: "\(baseURL)pokemon?limit=\(limit)&offset=\(offset)=\(pageNumber)")
    case .getPokemonDetails(let id):
      return URL(string: "\(baseURL)pokemon/\(id)")
    case .getPokemonSpecies(let id):
      return URL(string: "\(baseURL)pokemon-species/\(id)")
    }
  }
}

protocol APIServiceProtocol {
  func getPokemons(offset: Int, limit: Int, pageNumber: Int) -> Single<PokemonResponse?>
  func getPokemonDetail(with id: Int) -> Single<PokemonDetailResponse?>
  func getPokemonSpecies(id: Int) -> Single<PokemonSpeciesResponse?>
}

final class APIService: APIServiceProtocol {
  private let baseURL = "https://pokeapi.co/api/v2/"
  private let session = URLSession.shared
  
  static let shared = APIService()
  
  init() {}
  
  func getPokemons(offset: Int, limit: Int, pageNumber: Int) -> Single<PokemonResponse?> {
    return Single.create { [weak self] single in
      guard let self = self else {
        single(.failure(APIError.networkError))
        
        return Disposables.create()
      }
      
      let endpoint = APIEndpoint.getPokemons(offset: offset, limit: limit, pageNumber: pageNumber)
      self.makeRequest(endpoint: endpoint, method: .GET, responseType: PokemonResponse.self) { result in
        switch result {
        case .success(let response):
          single(.success(response))
        case .failure(let error):
          single(.failure(error))
        }
      }
      
      return Disposables.create()
    }
  }
  
  func getPokemonDetail(with id: Int) -> Single<PokemonDetailResponse?> {
    return Single.create { [weak self] single in
      guard let self = self else {
        single(.failure(APIError.networkError))
        
        return Disposables.create()
      }
      
      let endpoint = APIEndpoint.getPokemonDetails(id: id)
      self.makeRequest(endpoint: endpoint, method: .GET, responseType: PokemonDetailResponse.self) { result in
        switch result {
        case .success(let response):
          single(.success(response))
        case .failure(let error):
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }
  
  func getPokemonSpecies(id: Int) -> Single<PokemonSpeciesResponse?> {
    return Single.create { [weak self] single in
      guard let self = self else {
        single(.failure(APIError.networkError))
        
        return Disposables.create()
      }
      
      let endpoint = APIEndpoint.getPokemonSpecies(id: id)
      self.makeRequest(endpoint: endpoint, method: .GET, responseType: PokemonSpeciesResponse.self) { result in
        switch result {
        case .success(let response):
          single(.success(response))
        case .failure(let error):
          single(.failure(error))
        }
      }
      
      return Disposables.create()
    }
  }
  
  private func makeRequest<T: Codable>(
    endpoint: APIEndpoint,
    method: HTTPMethod,
    body: Data? = nil,
    responseType: T.Type,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    guard let url = endpoint.url else {
      completion(.failure(APIError.invalidURL))
      
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let body = body {
      request.httpBody = body
    }
    
    session.dataTask(with: request) { [weak self] data, response, error in
      self?.handleResponse(
        data: data,
        response: response,
        error: error,
        responseType: responseType,
        completion: completion
      )
    }.resume()
  }
  
  private func handleResponse<T: Codable>(
    data: Data?,
    response: URLResponse?,
    error: Error?,
    responseType: T.Type,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    if error != nil {
      completion(.failure(APIError.networkError))
      return
    }
    
    if let httpResponse = response as? HTTPURLResponse {
      guard 200...299 ~= httpResponse.statusCode else {
        completion(.failure(APIError.serverError(httpResponse.statusCode)))
        return
      }
    }
    
    guard let data = data else {
      completion(.failure(APIError.noData))
      return
    }
    
    do {
      let decodedResponse = try JSONDecoder().decode(responseType, from: data)
      completion(.success(decodedResponse))
    } catch {
      completion(.failure(APIError.decodingError))
    }
  }
}
enum HTTPMethod: String {
  case GET = "GET"
  case POST = "POST"
  case PUT = "PUT"
  case DELETE = "DELETE"
}
enum APIError: Error, LocalizedError {
  case invalidURL
  case noData
  case decodingError
  case networkError
  case serverError(Int)
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "Invalid URL"
    case .noData:
      return "No data received"
    case .decodingError:
      return "Failed to decode response"
    case .networkError:
      return "Network error occurred"
    case .serverError(let code):
      return "Server error with code: \(code)"
    }
  }
}
