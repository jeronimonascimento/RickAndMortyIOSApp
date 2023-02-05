//
//  RMService.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 01/02/23.
//

import Foundation


/// Serviço para recuperar dados da api
final class RMService {
    
    
    /// Instancia SINGLETON do serviço
    static let shared = RMService()
    
    private init() {}
    
    enum RMServiceError: Error {
        case failedCreateRequest
        case failedToGetData
    }
    
    /// Enviar Requisição
    /// - Parameters:
    ///   - request: Requisição
    ///   - type: Tipo esperado do objeto que esperamos receber de volta
    ///   - completion: callback com dados ou com erro
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,
                                    completion: @escaping(Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // MARK: - Private
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil}
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
