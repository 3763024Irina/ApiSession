//
//  NewsListViewController.swift
//  ApiSession
//
//  Created by Irina on 21/2/25.
//

import Foundation
import UIKit
class NewsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var news: [NewsArticle] = [] // Массив загруженных новостей
    
    // Коллекция для отображения списка новостей
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .cyan
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tesla News" // Заголовок экрана
        view.backgroundColor = .white
        setupCollectionView()
        fetchNews()
    }
    
    // Настройка коллекции
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "NewsCell")
        collectionView.allowsSelection = true

        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Загрузка новостей из API
    private func fetchNews() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2025-02-03&sortBy=publishedAt&apiKey=03f49428cd32430798305a7b47f0a692") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            // Выводим JSON-ответ в консоль
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📌 JSON-ответ: \(jsonString)")
            }
            
            do {
                let result = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.news = result.articles
                    self.collectionView.reloadData()
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }

    
    // Количество элементов в коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    // Заполнение ячеек данными
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.configure(with: news[indexPath.item])
        return cell
    }
    
    // Обработка нажатия на новость
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = news[indexPath.item]
        print("📰 Открываем новость: \(article.title)") 
        print("📌 navigationController: \(String(describing: navigationController))") // Проверка

        let detailVC = NewsDetailViewController(article: article)
        collectionView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            collectionView.isUserInteractionEnabled = true
        }
        print("📌 navigationController: \(String(describing: navigationController))")


        navigationController?.pushViewController(detailVC, animated: true)
    }
}
