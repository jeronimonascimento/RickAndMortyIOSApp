//
//  ImageManager.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 25/02/23.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    private var imageDataCache = NSCache<NSString, NSData>()
    private init (){
        
    }
    
    
    /// Recuperar imagem atraves da URL
    /// - Parameters:
    ///   - url: url da imagem
    ///   - completion: callback
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        
        if let cachedImage = imageDataCache.object(forKey: key) {
            completion(.success(cachedImage as Data))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            self?.imageDataCache.setObject(data as NSData, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
