//
//  CardsViewController.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 04/10/24.
//

import UIKit

class CardsViewController: UIViewController {
    
    var name = "default"
    var pokemon: [PokemonList] = []
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet{
            nameLabel.text = "Hola \(name)"
        }
    }
    
    @IBOutlet weak var cardCell: UICollectionView! {
        didSet {
            cardCell.dataSource = self
            cardCell.delegate = self
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 345, height: 345)
            cardCell.collectionViewLayout = layout
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardCell.delegate = self
        fetchPokemonData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerCells()
    }
    
    func registerCells() {
        cardCell.register(UINib(nibName: "CardsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardsCollectionViewCell")
    }
    
    
    func fetchPokemonData() {
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                do {
                    let pokemonList = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    DispatchQueue.main.async{
                        self.pokemon = pokemonList.results
                        self.cardCell.reloadData()
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }.resume()
        }
    }
}

extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCollectionViewCell", for: indexPath) as? CardsCollectionViewCell else { return UICollectionViewCell()}
        
        let currentPokemon = pokemon[indexPath.item] // Obtener el Pokémon actual
        cell.configure(with: currentPokemon)
        //print(currentPokemon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 345, height: 345)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Obtener el Pokémon correspondiente a la celda seleccionada
        let currentPokemon = pokemon[indexPath.item]
        let pokemonDetailController = PokemonDetailViewController (nibName: "PokemonDetailViewController", bundle: nil)
        let pokemonDetailNavigationController = UINavigationController(rootViewController: pokemonDetailController)
        pokemonDetailController.urlPokemon = currentPokemon.url
        pokemonDetailNavigationController.modalPresentationStyle = .fullScreen
        present(pokemonDetailNavigationController, animated: true)
    }
}
