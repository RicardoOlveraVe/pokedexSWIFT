//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 07/10/24.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let base_experience: Int
    let cries: Cries
    let abilities: [Ability]
    let moves: [Move]
    let sprites: Sprites
    let types: [PokemonType]
    let stats: [Stat]
}

// MARK: - Ability
struct Ability: Codable {
    let ability: NamedAPIResource
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Cries: Codable {
    let latest: String
    let legacy: String
    enum CodingKeys: String, CodingKey {
        case latest
        case legacy
    }
}

// MARK: - Move
struct Move: Codable {
    let move: NamedAPIResource
}

// MARK: - NamedAPIResource
struct NamedAPIResource: Codable {
    let name: String
    let url: String
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault: String?
    let frontShiny: String?
    let backDefault: String?
    let backShiny: String?
    let other: OtherSprites?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case other
    }
}

// MARK: - OtherSprites
struct OtherSprites: Codable {
    let officialArtwork: Artwork?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: - Artwork
struct Artwork: Codable {
    let frontDefault: String?
    let frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - PokemonType
struct PokemonType: Codable {
    let slot: Int
    let type: NamedAPIResource
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
