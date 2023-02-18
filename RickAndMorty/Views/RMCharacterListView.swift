//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 05/02/23.
//

import UIKit


/// View que trata a exibição dos characters
final class RMCharacterListView: UIView {
    
    let viewModel = RMCharacterListViewModel()
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, spinner)
        setupConstraints()
        spinner.startAnimating()
        viewModel.fetchCharacters()
        setupCollectionView()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1
            }
        })
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: topAnchor),
            spinner.rightAnchor.constraint(equalTo: rightAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}
