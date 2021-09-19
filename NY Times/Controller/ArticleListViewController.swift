//
//  ArticleListViewController.swift
//  NY Times
//
//  Created by Kiran R on 18/09/21.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    private var tableView : UITableView!
    
    private var listDataSource : ArticleListModel!
    
    private var optionBarButton: UIBarButtonItem!
    
    private var optionTableViewController: UITableViewController!
    
    private var optionTableViewDataSource = [1,7,30]

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
       
        loadArticleList { [weak self] response in
            
            guard let `self` = self else {return}
            
            guard case let (.success(isSuccess)) = response,
                  isSuccess else {
                return
            }
            
            self.setupView()
            
        }
        
    }
    
    deinit {
        print("ArticleListViewController DeInited")
    }
    
}

//MARK:- View
extension ArticleListViewController {
    
    private func setupView() {
       
        DispatchQueue.main.async {
            
            if (self.tableView == nil) {
                self.setupTableView()
                self.setNavigationBarItems()
            }
            
        }
        
    }
    
    private func setNavigationBarItems() {
        
        guard let font = UIFont(name: "AlNile-Bold", size: 20) else {
            return
        }
        
        self.navigationItem.title = "NY Times Most Popular"
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : font
        ]

        let mainMenuImage = UIImage(named: "hamburger")!.resizeImage(targetSize: CGSize(width: 30, height: 30))
        let mainMenuButton: UIButton = UIButton(type: .custom)
        mainMenuButton.setImage(mainMenuImage, for: .normal)
        mainMenuButton.addTarget(self, action: #selector(Self.onTapMainMenu) , for: .touchUpInside)
        mainMenuButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let mainMenuBarButton = UIBarButtonItem(customView: mainMenuButton)
        self.navigationItem.leftBarButtonItem = mainMenuBarButton
        
        let searchImage = UIImage(named: "search")!.resizeImage(targetSize: CGSize(width: 30, height: 30))
        let searchBtn: UIButton = UIButton(type: .custom)
        searchBtn.setImage(searchImage, for: .normal)
        searchBtn.addTarget(self, action: #selector(Self.onTapSearch) , for: .touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let searchBarBtn = UIBarButtonItem(customView: searchBtn)
        
        let optionImage = UIImage(named: "kabab")!.resizeImage(targetSize: CGSize(width: 30, height: 30))
        let optionButton: UIButton = UIButton(type: .custom)
        optionButton.setImage(optionImage, for: .normal)
        optionButton.addTarget(self, action: #selector(Self.onTapOption) , for: .touchUpInside)
        optionButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        optionBarButton = UIBarButtonItem(customView: optionButton)
        
        self.navigationItem.rightBarButtonItems = [optionBarButton, searchBarBtn]
        
    }
    
    private func setupTableView() {
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleListCell.self, forCellReuseIdentifier: "\(ArticleListCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
        
        constrainTableView()
        
    }
    
    private func constrainTableView() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
        
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
    }
    
    private func presentOptionTableViewPopOver() {
        
        optionTableViewController = UITableViewController(style: .plain)
        
        optionTableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        optionTableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        optionTableViewController.tableView.dataSource = self
        optionTableViewController.tableView.delegate = self
        
        optionTableViewController.view.backgroundColor = .white
        optionTableViewController.modalPresentationStyle = .popover
        optionTableViewController.modalTransitionStyle = .crossDissolve
        optionTableViewController.modalPresentationStyle = .popover
        
        let popup = optionTableViewController.popoverPresentationController
        popup?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popup?.delegate = self
        
        popup?.sourceView = optionBarButton.customView
        
        popup?.sourceRect = optionBarButton.customView!.bounds
        
        optionTableViewController.preferredContentSize = CGSize(width: 80, height: 135)
        self.present(optionTableViewController, animated: true, completion: nil)
        
    }
    
}

//MARK:- TableView Protocols
extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        if tableView == self.tableView {
            
            return listDataSource.results.count
            
        } else {
            
            return optionTableViewDataSource.count
            
        }
        
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier:  "\(ArticleListCell.self)", for: indexPath) as! ArticleListCell
            
            let viewModel = listDataSource.results[indexPath.row]
           
            cell.configureCell(ArticleListViewModel(viewModel))
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier:  "\(UITableViewCell.self)", for: indexPath)
            
            cell.textLabel?.text = optionTableViewDataSource[indexPath.row].description
            cell.textLabel?.textAlignment = .center
            return cell
            
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.tableView {
            
            let details = getArticleDetails(by: indexPath.row)
            
            let navigationController = UINavigationController(rootViewController:  ArticleDetailsViewController(articleDetails: details))
            
            navigationController.navigationBar.barTintColor = UIColor(red: 0.28, green: 0.88, blue: 0.76, alpha: 1.00)

            self.view.window?.rootViewController = navigationController
            
        } else {
            
            optionTableViewController.dismiss(animated: true, completion: nil)
            loadArticleList(self.optionTableViewDataSource[indexPath.row]) { response in
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }
       
    }
    
}

//MARK:- API
extension ArticleListViewController {
    
     func loadArticleList(_ period: Int = 1, completion: @escaping ((Swift.Result<Bool, NetworkErrors>) -> ())) {
        
        guard let url = getListUrl(period) else {
            completion(.failure(.wrongUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let `self` = self else {return}
            
            guard let articleListDataResponse = data else {
                completion(.failure(.unKnownResponse))
                return
            }
            
            do {
                
                self.listDataSource = try JSONDecoder().decode(ArticleListModel.self, from: articleListDataResponse)
                completion(.success(true))
                
            } catch let error {
                
                completion(.failure(error as! NetworkErrors))
                
            }
            
        }.resume()
      
    }
    
}

//MARK:- Utility methods
extension ArticleListViewController {
    
     func getListUrl(_ period: Int) -> URL? {
        
        guard let url = URL(string:"https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/\(period).json?api-key=Dm606adM66tyKNyIozHwv6qQ0SrOnEL0") else {
            
            return URL(string: "")
            
        }
        return url
    }
    
    private func getArticleDetails(by index: Int) -> [String : String] {
        
        let results = self.listDataSource.results[index]
        let details : [String : String] = [
        
            "Abstract"        : results.abstract,
            "Adx Keywords"    : results.adxKeywords,
            "Byline"          : results.byline,
            "Nyt dsection"    : results.nytdsection,
            "Section"         : results.section,
            "Sub section"     : results.subsection,
            "Title"           : results.title,
            "Url"             : results.url,
            "DesFacet"        : results.desFacet.joined(separator: ", "),
            "GeoFacet"        : results.geoFacet.joined(separator: ", "),
            "OrgFacet"        : results.orgFacet.joined(separator: ", "),
            "PerFacet"        : results.perFacet.joined(separator: ", "),
        
        ]
        
        return details
        
    }
    
}

//MARK:- Targets
extension ArticleListViewController {
    
    @objc func onTapMainMenu(_ sender: UIBarButtonItem) {
        print("onTapped MainMenu")
    }

    @objc func onTapSearch(_ sender: UIBarButtonItem) {
        print("onTapped Search")
    }

    @objc func onTapOption(_ sender: UIBarButtonItem) {
       
        presentOptionTableViewPopOver()
        
    }
    
}

//MARK:- Delegates
extension ArticleListViewController: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
}
