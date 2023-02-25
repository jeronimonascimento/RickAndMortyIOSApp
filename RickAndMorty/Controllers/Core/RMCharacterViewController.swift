//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 01/02/23.
//
 
import UIKit

/// Controller para buscar dados dos personagens
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {
    
    private lazy var characterListView: RMCharacterListView = {
        let characterListView = RMCharacterListView()
        characterListView.delegate = self
        characterListView.translatesAutoresizingMaskIntoConstraints = false
        return characterListView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        view.addSubview(characterListView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    // MARK: - RMCharacterListViewDelegate
    
    func rmCharacterListView(_ listView: RMCharacterListView, _ character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
