//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 08/10/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var urlPokemon = ""
    
    var firstType = ""
    var secondType = ""
    var hp = ""
    var attack = ""
    var defense = ""
    var sa = ""
    var sd = ""
    var speed = ""
    
    var pokemonDetail: Pokemon!
    
    @IBOutlet weak var cardCell: UICollectionView! {
        didSet {
            cardCell.dataSource = self
            cardCell.delegate = self
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 400, height: 630)
            cardCell.collectionViewLayout = layout
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        cardCell.delegate = self
        fetchPokemonData()
        // Do any additional setup after loading the view.
    }

    func registerCells() {
        cardCell.register(UINib(nibName: "DetailPokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailPokemonCollectionViewCell")
    }

    func fetchPokemonData() {
        guard let url = URL(string: urlPokemon) else {return}
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                self!.pokemonDetail = pokemon
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
        
    }
    
   
}

extension PokemonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailPokemonCollectionViewCell", for: indexPath) as? DetailPokemonCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configure(with: pokemonDetail)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 630)
        
    }
    
}
