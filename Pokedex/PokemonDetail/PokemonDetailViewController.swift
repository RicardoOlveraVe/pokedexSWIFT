//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ricardo Olvera Velasco on 08/10/24.
//

import UIKit
import OggDecoder
import AVFoundation

class PokemonDetailViewController: UIViewController {
    
    var urlPokemon = ""
    
    //var criesSound = "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/2.ogg"
    
    var firstType = ""
    var secondType = ""
    var hp = ""
    var attack = ""
    var defense = ""
    var sa = ""
    var sd = ""
    var speed = ""
    
    var pokemonDetail: Pokemon!
    var decoderOGG = OGGDecoder()
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var bkbtn: UIButton!
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
       //playSoundButtonTapped()
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
   
   /*func playSoundButtonTapped() {
           guard let soundURL = URL(string: criesSound) else {
               print("Invalid sound URL")
               return
           }
      print(soundURL)

           // Descarga el archivo temporalmente
           downloadFile(from: soundURL) { [weak self] localURL, error in
              print(localURL)
               if let error = error {
                   print("Error downloading file: \(error.localizedDescription)")
                   return
               }

               guard let localURL = localURL else { return }

               // Decodifica el archivo OGG
               do {
                   let decodedData = self?.decoderOGG.decode(localURL)
                  self?.playAudio(with: try Data(contentsOf: decodedData!))
               } catch {
                   print("Error decoding sound: \(error)")
               }
           }
       }

       func downloadFile(from url: URL, completion: @escaping (URL?, Error?) -> Void) {
           let task = URLSession.shared.downloadTask(with: url) { tempLocalURL, response, error in
               if let error = error {
                   completion(nil, error)
                   return
               }

               // Asegúrate de que se ha recibido un archivo
               guard let tempLocalURL = tempLocalURL else {
                   completion(nil, NSError(domain: "DownloadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No file downloaded."]))
                   return
               }

               // Retorna la URL del archivo temporal
               completion(tempLocalURL, nil)
           }
           task.resume()
       }
       
       func playAudio(with data: Data?) {
           guard let data = data else { return }
           do {
               audioPlayer = try AVAudioPlayer(data: data)
               audioPlayer?.prepareToPlay()
               audioPlayer?.play()
           } catch {
               print("Error playing sound: \(error)")
           }
       }*/
    
     
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
