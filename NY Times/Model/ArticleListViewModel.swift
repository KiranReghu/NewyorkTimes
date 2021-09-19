//
//  ArticleListViewModel.swift
//  NY Times
//
//  Created by Kiran R on 18/09/21.
//

import Foundation


class ArticleListViewModel {
    
    let abstract        : String
    let byline          : String
    let publishedDate   : String
    let id              : Int
    
    init(_ model: Result) {
        
        self.abstract = model.abstract
        self.byline = model.byline
        self.publishedDate = model.publishedDate
        self.id = model.id
        
    }
    
}


