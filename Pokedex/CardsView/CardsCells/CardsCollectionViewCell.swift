//
//  CardsCollectionViewCell.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 05/10/24.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    
    var color = ColorTypes.colors(for: "grass")
    var firstColor: UIColor!
    var secondColor: UIColor!
    var thirdColor: UIColor!
    
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        
        bgGradient.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //Función para bordes de tarjeta
    func setBorders() {
        self.layer.borderColor = firstColor.cgColor // Color del borde
        self.layer.borderWidth = 2.0 // Ancho del borde
        self.layer.cornerRadius = 10.0 // (Opcional) Redondear las esquinas
        self.layer.masksToBounds = true // Asegura que los subelementos respeten las esquinas redondeadas
        nameLabel.textColor = firstColor
    }
    
}
