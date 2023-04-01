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
    let endpoint: RMEndpoint
    
    
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
    
    convenience init?(url: URL) {
        let absoluteString = url.absoluteString
        if !absoluteString.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmedUrl = absoluteString.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmedUrl.contains("/") {
            let components = trimmedUrl.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpont = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpont, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmedUrl.contains("?") {
            let components = trimmedUrl.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0],
                                        value: parts[1])
                })
                if let rmEndpont = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpont, queryParameters: queryItems)
                    return
                }
            }
        }
        
        return nil
    }
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
}
