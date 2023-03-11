//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 19/02/23.
//

import Foundation
import UIKit

/// View model do detalhe do personagem
final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    public enum SectionTypes {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionTypes] = []
    
    init(character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: .init(imageURL: URL(string: character.image))),
            .information(viewModels: [
                .init(value: character.name, type: .name),
                .init(value: character.type, type: .type),
                .init(value: character.gender.rawValue, type: .gender),
                .init(value: character.species, type: .species),
                .init(value: character.origin.name, type: .origin),
                .init(value: character.location.name, type: .location),
                .init(value: character.created, type: .created),
                .init(value: "\(character.episode.count)", type: .episodeCount)
            ]),
            .episodes(viewModels:
                character.episode.compactMap({
                    return RMCharacterEpisodeCollectionViewCellViewModel(episodeURL: URL(string: $0))
                })
            )
        ]
    }
    
    public var title: String {
        return character.name.uppercased()
    }
    
    private var requestURL: URL? {
        guard let url = URL(string: character.url) else { return nil }
        return url
    }
    
    // MARK: - Create collectionView
    
    public func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(RMCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)
        return collectionView
    }
    
    public func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        switch sections[sectionIndex] {
        case .photo:
            return createPhotoLayoutSection()
        case .information:
            return createInformationLayoutSection()
        case .episodes:
            return createEpisodeLayoutSection()
        }
    }
    
    public func createPhotoLayoutSection() -> NSCollectionLayoutSection{
        let layoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                   heightDimension: .fractionalHeight(1.0)))
        
        layoutItem.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                        heightDimension: .fractionalHeight(0.5)),
                                                     subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        return layoutSection
    }
    
    public func createInformationLayoutSection() -> NSCollectionLayoutSection{
        let layoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                   heightDimension: .fractionalHeight(1.0)))
        layoutItem.contentInsets = .init(top: 0, leading: 2, bottom: 2, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                          heightDimension: .absolute(120)),
                                                       subitems: [layoutItem, layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        return layoutSection
    }
    
    public func createEpisodeLayoutSection() -> NSCollectionLayoutSection{
        let layoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                   heightDimension: .fractionalHeight(1.0)))
        
        layoutItem.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                                                          heightDimension: .absolute(120)),
                                                       subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        return layoutSection
    }
}
