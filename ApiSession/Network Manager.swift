//
import Moya

class NetworkManager {
    let provider = MoyaProvider<NewsAPI>()

    func fetchTeslaNews(completion: @escaping ([NewsArticle]?) -> Void) {
        provider.request(.getTeslaNews) { result in
            switch result {
            case .success(let response):
                do {
                    let newsResponse = try JSONDecoder().decode([String: [NewsArticle]].self, from: response.data)
                    completion(newsResponse["articles"])
                } catch {
                    print("Ошибка парсинга: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("Ошибка запроса: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
