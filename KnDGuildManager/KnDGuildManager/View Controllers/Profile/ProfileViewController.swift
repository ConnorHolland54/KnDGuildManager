//
//  ProfileViewController.swift
//  KnDGuildManager
//
//  Created by Connor Holland on 11/2/20.
//

import UIKit
import SideMenu
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var menu: SideMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuSetup()
        PlayerController.shared.fetchCurrentPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Helper Methods
    func sideMenuSetup() {
        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
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
