//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 02/10/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var startBtn: UIButton!{
        didSet{
            startBtn.isEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.addTarget(self, action: #selector(isEnable(_:)), for: .editingChanged)
    }
    
    @objc func isEnable(_ sender: UITextField) {
        startBtn.isEnabled = sender.text?.count ?? 0 >= 3
    }
    
    @IBAction func playClick(_ sender: Any){
        let cardViewController = CardsViewController (nibName: "CardsViewController", bundle: nil)
        let cardNavigationController = UINavigationController(rootViewController: cardViewController)
        cardViewController.name = nameLabel.text!
        cardNavigationController.modalPresentationStyle = .fullScreen
        present(cardNavigationController, animated: true)
    }

}
