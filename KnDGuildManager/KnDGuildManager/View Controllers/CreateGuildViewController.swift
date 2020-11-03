//
//  CreateGuildViewController.swift
//  KnDGuildManager
//
//  Created by Connor Holland on 11/3/20.
//

import UIKit

class CreateGuildViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var guildNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let name = guildNameTextField.text, !name.isEmpty else {return}
        GuildController.shared.createGuild(name: name)
        guildNameTextField.text = ""
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
