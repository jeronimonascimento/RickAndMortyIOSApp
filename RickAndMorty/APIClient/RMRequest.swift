//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 01/02/23.
//

import Foundation


/// Representa uma requisição
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    
    /// Endpoint desejado
    private let endpoint: RMEndpoint
    
    
    /// Path varibles da URM
    private let pathComponents: [String]
    
    
    /// Parâmetros
    private let queryParameters: [URLQueryItem]
    
    
    /// URL construída no formato de String
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {(
                string += "/\($0)"
            )}
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    // MARK: - Public API
    
    
    /// URL Completa com todos os componentes
    public var url: URL? {
      return URL(string: urlString)
    }
    
    
    /// HTTP Método desejado
    public let httpMethod = "GET"
    
    
    /// Inicializador da requisição
    /// - Parameters:
    ///   - endpoint: Endpoint desejado
    ///   - pathComponents: Collection de parâmetros da URL
    ///   - queryParameters: Collection dos query param
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
