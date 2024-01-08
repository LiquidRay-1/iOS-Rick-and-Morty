//
//  ViewController.swift
//  RickAndMorty
//
//  Created by dam2 on 14/12/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var personajes = [Personaje]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personajes"
        collectionView.dataSource = self
        collectionView.delegate = self
        downloadData()
    }
    
    func downloadData(){
        let urlString = "https://rickandmortyapi.com/api/character"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, responde, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            
            if let response = responde as? HTTPURLResponse {
                print(response)
            }
            
            guard let data = data else { return }
            
            let personajes = try? JSONDecoder().decode(RespuestaPersonajes.self, from: data) 
            
            if personajes != nil {
                self.personajes = personajes!.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }else{
                print("No es el universo que buscas")
            }
            
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = collectionView.frame.width
        var celdaWidth = 0
        
        if screenWidth > 700 {
            celdaWidth = Int(screenWidth/5 - 12)
        } else {
            celdaWidth = Int(screenWidth/2 - 8)
        }
        return CGSize(width: celdaWidth, height: celdaWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        personajes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ViewController2") as! ViewController2
        vc.personaje = personajes[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! MiCelda
        cell.miLabel1.text = personajes[indexPath.item].name
        cell.miLabel2.text = personajes[indexPath.item].species
        let imageURL = URL(string: personajes[indexPath.item].image)
        let dataTask = URLSession.shared.dataTask(with: imageURL!){ (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.miImagen.image = UIImage(data: data)
                    
                }
            }
        }
        dataTask.resume()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }

}

