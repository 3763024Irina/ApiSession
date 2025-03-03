//
//  NewsResponse.swift
//  ApiSession
//
//  Created by Irina on 21/2/25.
import Foundation
import UIKit
struct NewsResponse: Decodable {
    let articles: [NewsArticle]
}


struct NewsArticle: Decodable {
    let title: String
    let description: String?
    let url: String?  // Должно быть опциональным
    let urlToImage: String?
}
