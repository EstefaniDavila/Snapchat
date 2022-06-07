//
//  ViewController.swift
//  Snapchat1
//
//  Created by Mac 17 on 26/05/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FacebookLogin
import FirebaseDatabase


class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var password: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func iniciarSesionTapped(_ sender: Any ) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: password.text!){
             (user, error) in print("intentando iniciar sesión")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                
                let alert = UIAlertController(title: "Se encontro un error", message: "Usuario \(self.emailTextField.text!) incorrecto, cree uno o intentelo de nuevo", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Crear", style: .default, handler: { (action) in
                    self.performSegue(withIdentifier: "crearUsuarioSegue", sender: nil)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
                    
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                print("Inicio de sesion exitoso")
                
                let alerta = UIAlertController(title: "Inició sesión de forma exitosa", message: "Usuario: \(self.emailTextField.text!) accedió correctamente" , preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in self.performSegue(withIdentifier: "Iniciarsesionsegue", sender: nil)
                })
                alerta.addAction(btnOk)
                self.present(alerta, animated: true, completion: nil)
                
         
                    
                }
            
            
            
        }
    }
    
    

    @IBAction func FacebookLogin(_ sender: Any) {
        let loginManager = LoginManager()
                loginManager.logIn(permissions: ["publicprofile","email"], viewController: self) { (result) in

                    switch result {
                    case .success(granted: let granted, declined: let declined, token: let token):
                        let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)

                        Auth.auth().signIn(with: credential) { (result, error) in
                            print("Iniciando sesion con Facebook...")
                            if error != nil{
                                print("Se presento el siguiente error (error)")
                            }else{
                                print("Se inicio sesion con Facebook!!")
                            }

                        }
                    case .cancelled:
                        break
                    case .failed(_):
                        break
                    }

                }

            }
    
 
}

