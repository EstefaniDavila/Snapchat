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

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: password.text!){
             (user, error) in print("intentando iniciar sesión")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text! , password: self.password.text!, completion: {(user, error) in print("Intentando crear un usuario")
                    if error != nil {
                        print("Se presento el siguiente error al crear el usuario: \(error) ")
                    }else{
                        print("El usuario fue creado exitosamente")
                        
                        Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                        
                        let alerta = UIAlertController(title: "Creación de Usuario ", message: "Usuario: \(self.emailTextField.text!) se creo correctamente" , preferredStyle: .alert)
                        let btnOk = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in self.performSegue(withIdentifier: "Iniciarsesionsegue", sender: nil)
                        })
                        alerta.addAction(btnOk)
                        self.present(alerta, animated: true, completion: nil)
                        
                    }
                })
            }else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "Iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    
    @IBAction func FacebookLogin(_ sender: Any) {
        let loginManager = LoginManager()
                loginManager.logIn(permissions: ["publicprofile","email"], viewController: self) { (result) in

                    switch result {
                    case .success(granted: let granted, declined: let declined, token: let token):
                        let datos = FacebookAuthProvider.credential(withAccessToken: token.tokenString)

                        Auth.auth().signIn(with: datos) { (result, error) in
                            print("Logging with Facebook...")
                            if error != nil{
                                print("Al iniciar sesión se presento el siguiente error (error)")
                            }else{
                                print("successful Facebook login!!!")
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

