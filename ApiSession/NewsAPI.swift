import Foundation
import Moya

enum NewsAPI {
    case getTeslaNews
}

extension NewsAPI: TargetType {
    var baseURL: URL { URL(string: "https://newsapi.org/v2")! }

    var path: String {
        switch self {
        case .getTeslaNews:
            return "/everything"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "NEWS_API_KEY") as? String ?? ""

        let parameters: [String: Any] = [
            "q": "tesla",
            "from": "2025-02-01",
            "sortBy": "publishedAt",
            "apiKey": apiKey
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}
