//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 19/03/23.
//

import UIKit


/// Search Controller configurável
final class RMSearchViewController: UIViewController {
    
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        let type : `Type`
    }

    private let config: Config
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
    }
    
    // MARK: - Init
    
    public init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
}
