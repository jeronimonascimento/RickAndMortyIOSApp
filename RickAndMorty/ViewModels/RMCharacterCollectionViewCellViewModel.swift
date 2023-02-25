//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 15/02/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable{
    
    public let characterName: String?
    private let characterURL: URL?
    private let characterStatus: RMCharacterStatus
    
    public init(characterName: String?,
                characterURL: URL?,
                characterStatus: RMCharacterStatus) {
        
        self.characterName = characterName
        self.characterURL = characterURL
        self.characterStatus = characterStatus
        
    }
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterURL)
        hasher.combine(characterStatus)
    }
    
    public var characterStatusText: String {
        return characterStatus.rawValue
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        //TODO: - Abstrair
        guard let url = characterURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
