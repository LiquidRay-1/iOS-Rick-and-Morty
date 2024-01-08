//
//  ViewController2.swift
//  RickAndMorty
//
//  Created by dam2 on 20/12/23.
//

import UIKit

class ViewController2: UIViewController {
    
    var personajes = [Personaje]()

    @IBOutlet weak var nombrePersonaje: UILabel!
    @IBOutlet weak var especiePersonaje: UILabel!
    @IBOutlet weak var estadoPersonaje: UILabel!
    @IBOutlet weak var generoPersonaje: UILabel!
    @IBOutlet weak var localizacionPersonaje: UILabel!
    @IBOutlet weak var origenPersonaje: UILabel!
    @IBOutlet weak var imagenPersonaje: UIImageView!
    
    var personaje: Personaje?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let miPersonaje = personaje {
            title = miPersonaje.name
            nombrePersonaje.text = ("Nombre: ") + miPersonaje.name
            especiePersonaje.text = ("Especie: ") + miPersonaje.species
            estadoPersonaje.text = ("Estatus: ") + miPersonaje.status
            generoPersonaje.text = ("Género: ") + miPersonaje.gender
            localizacionPersonaje.text = ("Localización: ") + miPersonaje.location.name
            origenPersonaje.text = ("Origen: ") + miPersonaje.origin.name
            let imageURL = URL(string: miPersonaje.image)
            let dataTask = URLSession.shared.dataTask(with: imageURL!){ (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imagenPersonaje.image = UIImage(data: data)
                        
                    }
                }
            }
            dataTask.resume()
        }
    }
}
