//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 01/02/23.
//

import UIKit

/// Controller para buscar dados dos personagens
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: \(model.info.count) Pages: \(model.info.pages)")
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

}
