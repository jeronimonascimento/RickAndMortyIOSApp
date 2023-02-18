//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 05/02/23.
//

import UIKit

final class RMCharacterListViewModel: NSObject {
    func fetchCharacters() {
        
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Exemple URL: \(model.results.first?.image ?? "sem URL")")
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = RMCharacterCollectionViewCellViewModel(characterName: "Jed",
                                                               characterURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                                                               characterStatus: .alive)
        cell.configure(with: viewModel)
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }

}
