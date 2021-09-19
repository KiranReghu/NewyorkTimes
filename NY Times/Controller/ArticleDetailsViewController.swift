//
//  ArticleDetailsViewController.swift
//  NY Times
//
//  Created by Kiran R  on 18/09/21.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    private var articleDetails: [String : String] = [:]
    
    private var utility = Utility()
    
    private var mainStackView: UIStackView!
    
    private var mainScrollView: UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        setupView()
        
    }
  
    init(articleDetails: [String : String]) {
        
        super.init(nibName: nil, bundle: nil)
        self.articleDetails = articleDetails
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ArticleDetailsViewController DeInited")
    }

}

//MARK:- View
extension ArticleDetailsViewController {
    
    private func setupView() {
        
        view.backgroundColor = .white
        setupBackButton()
        setupDetailsView()
      
    }
    
    private func setupBackButton() {
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "\u{276E} Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClick(sender:)))
        newBackButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    private func setupDetailsView() {
        
        setupMainScrollView()
        
        mainStackView = utility.getStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 5)
        
        utility.setStackViewPadding(mainStackView, top: 20, leading: 20, bottom: 20, trailing: 20)
        
        articleDetails.forEach { item in
            
            let keylabel = utility.getLabel(UIFont(name: "AlNile-Bold", size: 20)!, color: .lightGray, numberOfLines: 0)
            keylabel.textAlignment = .left
            keylabel.text =  item.key + " :"
            
            let valuelabel = utility.getLabel(UIFont(name: "AlNile-Bold", size: 20)!, color: .darkGray, numberOfLines: 0)
            valuelabel.text = item.value
            
            let horizontalStackView =  utility.getStackView(axis: .horizontal, alignment: .fill, distribution: .fillProportionally, spacing: 5)
            horizontalStackView.addArrangedSubview(keylabel)
            horizontalStackView.addArrangedSubview(valuelabel)
            
            mainStackView.addArrangedSubview(horizontalStackView)
            
        }
        
        setupConstrainDetailsView()
        
    }
    
    private func setupMainScrollView() {
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
       
        self.view.addSubview(mainScrollView)
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
        ])
        
    }
    
    private func setupConstrainDetailsView() {
        
        mainScrollView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -5)
        ])
        
    }
    
}

//MARK:- Targets
extension ArticleDetailsViewController {
    
    @objc func backButtonClick(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
        let navigationController = UINavigationController(rootViewController:  ArticleListViewController())
        
        navigationController.navigationBar.barTintColor = UIColor(red: 0.28, green: 0.88, blue: 0.76, alpha: 1.00)

        self.view.window?.rootViewController = navigationController
        
    }
    
}
