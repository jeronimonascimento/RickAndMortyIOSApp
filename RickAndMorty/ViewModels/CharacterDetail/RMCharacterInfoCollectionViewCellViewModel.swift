//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Jerônimo Nascimento on 03/03/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    private let type: SectionType
    private let value: String
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    private static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    public lazy var displayTitle: String = {
        switch type {
        case .name,.type,.gender,.species,.origin,.location,.created:
            return type.rawValue.capitalized
        case .episodeCount:
            return "Episode Count"
        }
    }()
    
    public lazy var displayValue: String = {
        if value.isEmpty{ return "None" }
        
        switch type {
        case .created:
            guard let date = Self.dateFormatter.date(from: value) else {
                return "Failed do parse date"
            }
            return Self.shortDateFormatter.string(from: date)
        default: return value
        }
    }()
    
    public lazy var tintColor: UIColor = {
        switch self.type {
        case .name:
            return .systemPink
        case .type:
            return .systemGreen
        case .gender:
            return .systemBlue
        case .species:
            return .systemPurple
        case .origin:
            return .systemRed
        case .location:
            return .systemCyan
        case .created:
            return .systemYellow
        case .episodeCount:
            return .systemTeal
        }
    }()
    
    public lazy var icon: UIImage? = {
        return UIImage(systemName: "bell")
    }()
    
    enum SectionType: String {
        case name
        case type
        case gender
        case species
        case origin
        case location
        case created
        case episodeCount
    }
    
    init(value: String, type: SectionType) {
        self.value = value
        self.type = type
    }
}
