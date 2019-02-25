//
//  HomeController.swift
//  HelpHoReCa_IOS
//
//  Created by Mark on 12/02/2019.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    // MARK: - Properties
    
    var delegate: HomeControllerDelegate?
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
        // MARK: - Handlers
    
    @objc func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Главное меню"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
