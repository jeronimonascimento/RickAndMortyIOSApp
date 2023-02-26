//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 19/02/23.
//

import Foundation


/// View model do detalhe do personagem
final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    public enum SectionTypes: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public var sections: [SectionTypes] {
        return SectionTypes.allCases
    }
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        return character.name.uppercased()
    }
    
    private var requestURL: URL? {
        guard let url = URL(string: character.url) else { return nil }
        return url
    }
}
