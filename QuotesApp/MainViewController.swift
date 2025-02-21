//
//  ViewController.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 21.02.2025.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavbar()
    }


}

private extension MainViewController {
    
    func setupUI() {
        view.backgroundColor = .white

        
        
        
    }
    
    func setupNavbar() {
        let imageView = UIImageView(image: UIImage(named: "titleImg"))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
            navigationItem.titleView = imageView
    }

}


#Preview {MainViewController() }
