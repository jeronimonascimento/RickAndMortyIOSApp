//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 11/03/23.
//

import UIKit

/// VC para detalhar episódio selecionado
final class RMEpisodeDetailViewController: UIViewController {
    
    private let url: URL?
    
    //MARK: - Init
    
    public init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemCyan

        // Do any additional setup after loading the view.
    }

}
