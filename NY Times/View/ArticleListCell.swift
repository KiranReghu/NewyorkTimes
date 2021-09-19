//
//  ArticleListCell.swift
//  NY Times
//
//  Created by Kiran R on 18/09/21.
//

import UIKit

class ArticleListCell: UITableViewCell {

    private var dataSource: ArticleListViewModel!
    
    private var mainStackView: UIStackView!
    
    private var utility = Utility()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(_ model: ArticleListViewModel) {
        
        dataSource = model
        setUpView()
        
    }
    
    deinit {
        print("ArticleListCell DeInited")
    }
    
}

//MARK:- Private Methods
extension ArticleListCell {
    
    private func setUpView() {
        
        mainStackView?.subviews.forEach { _view in
            _view.removeFromSuperview()
        }
        
        mainStackView = utility.getStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 10)
        
        utility.setStackViewPadding(mainStackView, top: 20, leading: 30, bottom: 20, trailing: 30)
        
        let roundedView = utility.getRoundedView(50, radius: 25)
        
        let abstractLabel = utility.getLabel( UIFont(name: "AlNile-Bold", size: 20)!, color: .darkGray, numberOfLines: 2)

        abstractLabel.text = dataSource.abstract

        let byLineLabel = utility.getLabel( UIFont(name: "AlNile-Bold", size: 18)!, color: .gray, numberOfLines: 2)

        byLineLabel.text = dataSource.byline

        let publishedDateView = utility.getIconWithLabelView( UIFont(name: "AlNile-Bold", size: 25)!, color: .darkGray, iconName: "calender", labelName: dataSource.publishedDate, size: 20)

        let horizontalStackView = utility.getStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 2)

        horizontalStackView.addArrangedSubview(byLineLabel)

        horizontalStackView.addArrangedSubview(publishedDateView)

        let verticalStackView = utility.getStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 5)

        verticalStackView.addArrangedSubview(abstractLabel)

        verticalStackView.addArrangedSubview(horizontalStackView)

        let arrowView = utility.getIconView(name: "arrow", size: 15, color: .darkGray)
        
        mainStackView.addArrangedSubview(roundedView)
        
        mainStackView.addArrangedSubview(verticalStackView)

        mainStackView.addArrangedSubview(arrowView)
        
        constrainMainView(mainStackView)
        
    }
    
    private func constrainMainView(_ mainView : UIStackView) {
        
        self.contentView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
        
    }
    
}
