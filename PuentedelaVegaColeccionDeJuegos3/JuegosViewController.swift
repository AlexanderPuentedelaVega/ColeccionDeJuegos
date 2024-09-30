//
//  JuegosViewController.swift
//  PuentedelaVegaColeccionDeJuegos3
//
//  Created by Alexander Puente de la Vega on 30/09/24.
//

import UIKit

class JuegosViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tituloTextField: UITextField!
     var imagePicker = UIImagePickerController()
    @IBAction func agregarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            
            // Asignar el título del juego
            juego.titulo = tituloTextField.text
            
            // Asignar la imagen del juego en formato JPEG con una compresión del 50%
            juego.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
            
            // Guardar los cambios en Core Data
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // Regresar a la vista anterior
            navigationController?.popViewController(animated: true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        imageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
