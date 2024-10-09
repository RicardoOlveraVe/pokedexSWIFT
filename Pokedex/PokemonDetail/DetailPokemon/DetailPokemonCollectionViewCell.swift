//
//  DetailPokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 08/10/24.
//

import UIKit

class DetailPokemonCollectionViewCell: UICollectionViewCell {
    
    var firstColor: UIColor!
    var secondColor: UIColor!
    var thirdColor: UIColor!
    var color = ColorTypes.colors(for: "fire")
    var pokeType = ""
    var pokemonData: Pokemon!
    
    //Details of pokemon
    var firstType = ""
    var secondType = ""
    var hp = ""
    var attack = ""
    var defense = ""
    var sa = ""
    var sd = ""
    var speed = ""
    var id = ""
    var height = ""
    var weight = ""
    
    @IBOutlet weak var bgGradient: UIView!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var specialAttackLabel: UILabel!
    @IBOutlet weak var specialDefenseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ability1: UILabel!
    @IBOutlet weak var ability2: UILabel!
    @IBOutlet weak var hpSlider: UISlider!{
        didSet{
            configureSlider(hpSlider)
        }
    }
    @IBOutlet weak var attackSlider: UISlider!{
        didSet{
            configureSlider(attackSlider)
        }
    }
    @IBOutlet weak var defenseSlider: UISlider!{
        didSet{
            configureSlider(defenseSlider)
        }
    }
    @IBOutlet weak var specialAttackSlider: UISlider!{
        didSet{
            configureSlider(specialAttackSlider)
        }
    }
    @IBOutlet weak var specialDefenseSlider: UISlider!{
        didSet{
            configureSlider(specialDefenseSlider)
        }
    }
    @IBOutlet weak var speedSlider: UISlider!{
        didSet{
            configureSlider(speedSlider)
        }
    }
    
    func configureSlider(_ slider: UISlider) {
        slider.setThumbImage(UIImage(), for: .normal) // Oculta la bolita del slider
        slider.isUserInteractionEnabled = false       // Deshabilita la interacción del usuario
    }
    
    func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        pokemonData = pokemon
        setupImageView()
        mapData()
    }
    
    func setupImageView() {
        bgGradient.addSubview(pokeImage)
    }
    
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
    
    func setBorders() {
        self.layer.borderColor = firstColor.cgColor // Color del borde
        self.layer.borderWidth = 2.0 // Ancho del borde
        self.layer.cornerRadius = 10.0 //  Redondear las esquinas
        self.layer.masksToBounds = true // Asegura que los subelementos respeten las esquinas redondeadas
        nameLabel.textColor = firstColor
    }
    
    func mapData() {
        let imagePokemon = pokemonData.sprites.other?.officialArtwork?.frontDefault ?? ""
        pokeType = pokemonData.types[0].type.name
        hp = String(pokemonData.stats[0].baseStat)
        attack = String(pokemonData.stats[1].baseStat)
        defense = String(pokemonData.stats[2].baseStat)
        sa = String(pokemonData.stats[3].baseStat)
        sd = String(pokemonData.stats[4].baseStat)
        speed = String(pokemonData.stats[5].baseStat)
        heightLabel.text = String(pokemonData.height)
        weightLabel.text = String(pokemonData.weight)
        idLabel.text = "#\(pokemonData.id)"
        ability1.text = pokemonData.abilities[0].ability.name
        ability2.text = pokemonData.abilities[1].ability.name
        firstType = pokemonData.types[0].type.name
        if pokemonData.types.count > 1 {
            secondType = pokemonData.types[1].type.name
        } else {
            secondType = "-"
        }
        updateUI(with: imagePokemon)
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
                    self.type1.backgroundColor = ColorTypes.colors(for: self.firstType)?.firstColor
                    self.type1.text = self.firstType
                    self.type2.backgroundColor = ColorTypes.colors(for: self.secondType)?.firstColor
                    self.type2.text = self.secondType
                    self.type2.backgroundColor = ColorTypes.colors(for: self.secondType)?.firstColor
                    self.hpLabel.text = "\(self.hp)/150"
                    self.attackLabel.text = "\(self.attack)/150"
                    self.defenseLabel.text = "\(self.defense)/150"
                    self.specialAttackLabel.text = "\(self.sa)/150"
                    self.specialDefenseLabel.text = "\(self.sd)/150"
                    self.speedLabel.text = "\(self.speed)/150"
                    
                    self.hpSlider.value = Float(self.hp)!
                    self.attackSlider.value = Float(self.attack)!
                    self.defenseSlider.value = Float(self.defense)!
                    self.specialAttackSlider.value = Float(self.sa)!
                    self.specialDefenseSlider.value = Float(self.sd)!
                    self.speedSlider.value = Float(self.speed)!
                }
            }
        }
    }
}


