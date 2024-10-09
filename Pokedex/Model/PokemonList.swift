//
//  PokemonList.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 07/10/24.
//

import Foundation

// Modelo para un Pokémon
struct PokemonList: Codable {
    let name: String
    let url: String
}

// Modelo para la respuesta de la API que contiene múltiples Pokémon
struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonList]
}
