//
//  CardsViewController.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 04/10/24.
//

import UIKit

class CardsViewController: UIViewController {
    
    //@IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var cardCell: UICollectionView! {
        didSet {
            cardCell.dataSource = self
            cardCell.delegate = self
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 345, height: 345)
            cardCell.collectionViewLayout = layout
        }
    }
    
    var colorTest = "default"
    var color = ColorTypes.colors(for: "fire")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color = ColorTypes.colors(for: colorTest)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Llamar a la función del gradiente aquí para asegurarnos que viewTest tiene bounds válidos
        //setGradientBackground()
        registerCells()
    }
    
    func registerCells() {
        cardCell.register(UINib(nibName: "CardsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardsCollectionViewCell")
    }
    
}

extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCollectionViewCell", for: indexPath) as? CardsCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 345, height: 345)
        
    }
    
}

