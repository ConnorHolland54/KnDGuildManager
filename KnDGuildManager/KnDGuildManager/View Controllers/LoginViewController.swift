//
//  LoginViewController.swift
//  KnDGuildManager
//
//  Created by Connor Holland on 10/31/20.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var friendCodeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordOneTextField: UITextField!
    @IBOutlet weak var passwordTwoTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetup(setup: 1)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        buttonSetup(setup: 1)
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        buttonSetup(setup: 2)
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        submit()
    }
    
    // MARK: - Helper methods
    
    func submit() {
        
        if passwordTwoTextField.isHidden == false {
            
            guard let name = nameTextField.text, !name.isEmpty, let friendCode = friendCodeTextField.text, !friendCode.isEmpty, let email = emailTextField.text, !email.isEmpty, let passwordOne = passwordOneTextField.text, !passwordOne.isEmpty, let passTwo = passwordTwoTextField.text, !passTwo.isEmpty else {return}
            
            if passwordOne == passTwo {
                PlayerController.shared.createPlayer(name: name, friendCode: friendCode, email: email, pass: passwordOne) { (success) in
                    if success {
                        print("Created Player")
                        self.performSegue(withIdentifier: "toProfile", sender: self)
                    }
                }
            }
        } else {
            guard let email = emailTextField.text, !email.isEmpty, let pass = passwordOneTextField.text, !pass.isEmpty else {return}
            
            PlayerController.shared.signIn(email: email, pass: pass) { (success) in
                if success {
                    print("Signed In")
                    self.performSegue(withIdentifier: "toProfile", sender: self)
                }
            }
        }
    }
    
    
    
    func buttonSetup(setup: Int) {
        switch setup {
        case 1:
            loginButton.isSelected = true
            signUpButton.isSelected = false
            signUpButton.setTitleColor(.white, for: .selected)
            passwordTwoTextField.isHidden = true
            nameTextField.isHidden = true
            friendCodeTextField.isHidden = true
        case 2:
            loginButton.isSelected = false
            signUpButton.isSelected = true
            loginButton.setTitleColor(.white, for: .selected)
            passwordTwoTextField.isHidden = false
            nameTextField.isHidden = false
            friendCodeTextField.isHidden = false
        default:
            print("None")
        }
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
