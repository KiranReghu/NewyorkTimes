//
//  ViewController.swift
//  NY Times
//
//  Created by Kiran R on 18/09/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setLogoScreen()
    }

    deinit {
        print("ViewController DeInited")
    }
    
}

//MARK:- View
extension ViewController {
    
    private func setLogoScreen() {
        
        guard  let logoImage = UIImage(named: "logoImage") else {
            return
        }
        
        let imageView = UIImageView(image:logoImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        constrainLogoImage(imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           
            let navigationController = UINavigationController(rootViewController: ArticleListViewController())
            
            navigationController.navigationBar.barTintColor = UIColor(red: 0.28, green: 0.88, blue: 0.76, alpha: 1.00)

            self.view.window?.rootViewController = navigationController
            
        }
        
    }
    
    private func constrainLogoImage(_ imageView: UIImageView) {
        
        NSLayoutConstraint.activate([
        
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 250)
            
        ])
        
    }
    
}
