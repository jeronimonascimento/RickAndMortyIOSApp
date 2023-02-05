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
    
    
    /// Enviar Requisição
    /// - Parameters:
    ///   - request: Requisição
    ///   - type: Tipo esperado do objeto que esperamos receber de volta
    ///   - completion: callback com dados ou com erro
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,
                                    completion: @escaping(Result<T, Error>) -> Void) {
        
    }
}
