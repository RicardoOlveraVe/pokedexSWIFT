//
//  CardsCollectionViewCell.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 05/10/24.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    
    var imagePokemon = ""
    var pokeType = ""
    var firstColor: UIColor!
    var secondColor: UIColor!
    var thirdColor: UIColor!
    var color = ColorTypes.colors(for: "fire")
    
    var firstType = ""
    var secondType = ""
    var hp = ""
    var attack = ""
    var defense = ""
    var sa = ""
    var sd = ""
    var speed = ""
    
    
    
    @IBOutlet weak var bgGradient: UIView!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var specialAttackLabel: UILabel!
    @IBOutlet weak var specialDefenseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    
    private var imageURL: URL? {
        URL(string: imagePokemon)
    }
    
    func setupImageView() {
        //pokeImage.translatesAutoresizingMaskIntoConstraints = false
        bgGradient.addSubview(pokeImage)
    }
    
    func configure(with pokemon: PokemonList) {
        nameLabel.text = pokemon.name
        fetchPokemonData(from: pokemon.url)
        
        setupImageView()
        setGradientBackground()
        setBorders()
    }
    
    //Función para degradado del background
    func setGradientBackground() {
        //El guard nos asegura que el esquema de colores no es nil
        guard let color = color else {return}
        firstColor = color.firstColor
        secondColor = color.secondColor
        thirdColor = color.thirdColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            firstColor.cgColor,
            secondColor.cgColor,
            thirdColor.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = bgGradient.bounds
        
        if let sublayers = bgGradient.layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        bgGradient.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    //Función para bordes de tarjeta
    func setBorders() {
        self.layer.borderColor = firstColor.cgColor // Color del borde
        self.layer.borderWidth = 2.0 // Ancho del borde
        self.layer.cornerRadius = 10.0 //  Redondear las esquinas
        self.layer.masksToBounds = true // Asegura que los subelementos respeten las esquinas redondeadas
        nameLabel.textColor = firstColor
    }
    
    func fetchPokemonData(from url: String) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                let imagePokemon = pokemon.sprites.other?.officialArtwork?.frontDefault ?? ""
                self?.pokeType = pokemon.types[0].type.name
                self?.hp = String(pokemon.stats[0].baseStat)
                self?.attack = String(pokemon.stats[1].baseStat)
                self?.defense = String(pokemon.stats[2].baseStat)
                self?.sa = String(pokemon.stats[3].baseStat)
                self?.sd = String(pokemon.stats[4].baseStat)
                self?.speed = String(pokemon.stats[5].baseStat)
                self?.firstType = pokemon.types[0].type.name
                if pokemon.types.count > 1 {
                    self?.secondType = pokemon.types[1].type.name
                } else {
                    self?.secondType = "-"
                }
                self?.updateUI(with: imagePokemon)
                
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
        
    }
    
    private func updateUI(with imageUrlString: String) {
        guard let imageURL = URL(string: imageUrlString) else {return}
        
        DispatchQueue.global().async{
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async{
                    self.pokeImage.image = image
                    self.color = ColorTypes.colors(for: self.pokeType)
                    self.setGradientBackground()
                    self.setBorders()
                    self.type1.text = self.firstType
                    self.type2.text = self.secondType
                    self.hpLabel.text = self.hp
                    self.attackLabel.text = self.attack
                    self.defenseLabel.text = self.defense
                    self.specialAttackLabel.text = self.sa
                    self.specialDefenseLabel.text = self.sd
                    self.speedLabel.text = self.speed
                }
            }
        }
    }
    
}


