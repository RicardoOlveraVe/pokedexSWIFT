//
//  ColorTypes.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 04/10/24.
//

import UIKit

struct ColorTypes {
    
    static func colors(for type: String) -> (firstColor: UIColor, secondColor: UIColor, thirdColor: UIColor)? {
        switch type {
        case "grass":
            return (
                firstColor: UIColor(hex:"#7EC6C5"),
                secondColor: UIColor(hex:"#ABDAC6"),
                thirdColor: UIColor(hex:"#CAE099")
            )
        case "fire":
            return (
                firstColor: UIColor(hex:"#F96D6F"),
                secondColor: UIColor(hex:"#E35825"),
                thirdColor: UIColor(hex:"#E8AE1B")
            )
        case "water":
            return (
                firstColor: UIColor(hex:"#133258"),
                secondColor: UIColor(hex:"#1479FB"),
                thirdColor: UIColor(hex:"#82B2F1")
            )
        case "bug":
            return (
                firstColor: UIColor(hex:"#62DB60"),
                secondColor: UIColor(hex:"#3BB039"),
                thirdColor: UIColor(hex:"#AAFFA8")
            )
        case "normal":
            return (
                firstColor: UIColor(hex:"#735259"),
                secondColor: UIColor(hex:"#BC6B7C"),
                thirdColor: UIColor(hex:"#7C3F4C")
            )
        case "fighting":
            return (
                firstColor: UIColor(hex:"#96402A"),
                secondColor: UIColor(hex:"#F1613C"),
                thirdColor: UIColor(hex:"#CB735D")
            )
        case "poison":
            return (
                firstColor: UIColor(hex:"#5B3184"),
                secondColor: UIColor(hex:"#A564E3"),
                thirdColor: UIColor(hex:"#CE9BFF")
            )
        case "ghost":
            return (
                firstColor: UIColor(hex:"#323569"),
                secondColor: UIColor(hex:"#454AA8"),
                thirdColor: UIColor(hex:"#787DDA")
            )
        case "rock":
            return (
                firstColor: UIColor(hex:"#7E7E7E"),
                secondColor: UIColor(hex:"#8D8D94"),
                thirdColor: UIColor(hex:"#D3D3D3")
            )
        case "dark":
            return (
                firstColor: UIColor(hex:"#030706"),
                secondColor: UIColor(hex:"#0D1211"),
                thirdColor: UIColor(hex:"#5A5E5D")
            )
        case "ice":
            return (
                firstColor: UIColor(hex:"#6FBEDF"),
                secondColor: UIColor(hex:"#64CBF5"),
                thirdColor: UIColor(hex:"#BDEBFE")
            )
        case "steel":
            return (
                firstColor: UIColor(hex:"#5E736C"),
                secondColor: UIColor(hex:"#728881"),
                thirdColor: UIColor(hex:"#A8A8A8")
            )
        case "dragon":
            return (
                firstColor: UIColor(hex:"#478A93"),
                secondColor: UIColor(hex:"#56A4AE"),
                thirdColor: UIColor(hex:"#A2BEC1")
            )
        case "fairy":
            return (
                firstColor: UIColor(hex:"#971B45"),
                secondColor: UIColor(hex:"#C23867"),
                thirdColor: UIColor(hex:"#CD7D98")
            )
        case "electric":
            return (
                firstColor: UIColor(hex:"#0C1395"),
                secondColor: UIColor(hex:"#2B319B"),
                thirdColor: UIColor(hex:"#7075D9")
            )
        case "ground":
            return (
                firstColor: UIColor(hex:"#654008"),
                secondColor: UIColor(hex:"#895C1A"),
                thirdColor: UIColor(hex:"#D69638")
            )
        default:
            return (
                firstColor: UIColor(hex:"#121212"),
                secondColor: UIColor(hex:"#121212"),
                thirdColor: UIColor(hex:"#121212")
            )
        }
    }
}

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
