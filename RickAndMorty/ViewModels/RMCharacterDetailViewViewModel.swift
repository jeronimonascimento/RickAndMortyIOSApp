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
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        return character.name.uppercased()
    }
}
