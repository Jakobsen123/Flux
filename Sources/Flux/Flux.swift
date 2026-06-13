import Foundation

public enum RequestError: Error {
    case invalidURL
    case httpError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
}

public func sendGET<T: Decodable>(
    url: URL,
    as type: T.Type = T.self,
    headers: [String: String] = [:]
) async throws -> T {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

    let (data, response) = try await URLSession.shared.data(for: request)

    if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
        throw RequestError.httpError(statusCode: http.statusCode)
    }

    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        throw RequestError.decodingError(error)
    }
}
