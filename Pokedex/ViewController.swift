//
//  ViewController.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 02/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewTest: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
    }
    //FUNCION PARA BACKGROUND GRADIENTE
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor(hex: "#7EC6C5").cgColor,
            UIColor(hex: "#ABDAC6").cgColor,
            UIColor(hex: "#CAE099").cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        gradientLayer.frame = viewTest.bounds
        
        viewTest.layer.insertSublayer(gradientLayer, at: 0)
    }
}

/**
    Convierte Hexagesimales a RGB
 */
extension UIColor {
    convenience init(hex: String){
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
