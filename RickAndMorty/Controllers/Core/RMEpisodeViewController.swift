//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 01/02/23.
//

import UIKit

/// Controller para buscar dados dos episodios
final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {

    private lazy var episodeListView: RMEpisodeListView = {
        let episodeListView = RMEpisodeListView()
        episodeListView.delegate = self
        episodeListView.translatesAutoresizingMaskIntoConstraints = false
        return episodeListView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episode"
        
        view.addSubview(episodeListView)
        setupConstraints()
        addSearchButton()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        
    }
    
    // MARK: - RMCharacterListViewDelegate
    
    func rmEpisodeListView(_ listView: RMEpisodeListView, _ episode: RMEpisode) {
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
