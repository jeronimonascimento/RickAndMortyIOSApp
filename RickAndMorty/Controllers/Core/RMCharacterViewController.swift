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
        addSearchButton()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - RMCharacterListViewDelegate
    
    func rmCharacterListView(_ listView: RMCharacterListView, _ character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
