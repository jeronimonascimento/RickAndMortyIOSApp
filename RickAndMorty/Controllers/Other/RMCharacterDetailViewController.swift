//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 19/02/23.
//

import UIKit

class RMCharacterDetailViewController: UIViewController {
    
    private var viewModel: RMCharacterDetailViewViewModel?
    
    public init(viewModel: RMCharacterDetailViewViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        title = viewModel?.title
    }

}
