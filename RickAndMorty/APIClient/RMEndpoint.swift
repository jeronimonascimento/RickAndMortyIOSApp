//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 01/02/23.
//

import Foundation

/// Representa um endpoint
@frozen enum RMEndpoint: String, Hashable, CaseIterable {
    /// Endpoint para recuperar dados do personagem
    case character
    /// Endpoint para recuperar dados da localização
    case location
    /// Endpoint para recuperar dados do episodio
    case episode
}
