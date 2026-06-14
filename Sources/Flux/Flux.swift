import Foundation
public enum FluxError: Error {
    case invalidURL
    case httpError(statusCode: Int)
    case decodingError(Error)
    case encodingError(Error)
    case networkError(Error)
    case invalidResponse
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
        throw FluxError.httpError(statusCode: http.statusCode)
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        throw FluxError.decodingError(error)
    }
}

public func sendGETText(
    url: URL,
    headers: [String: String] = [:]
) async throws -> String {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

    let (data, response) = try await URLSession.shared.data(for: request)

    if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
        throw FluxError.httpError(statusCode: http.statusCode)
    }

    return String(data: data, encoding: .utf8) ?? ""
}


public func sendPOST<Body: Encodable, Response: Decodable>(
    url: URL,
    body: Body,
    as type: Response.Type = Response.self,
    headers: [String: String] = [:]
) async throws -> Response {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

    do {
        request.httpBody = try JSONEncoder().encode(body)
    } catch {
        throw FluxError.encodingError(error)
    }

    let (data, response) = try await URLSession.shared.data(for: request)

    if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
        throw FluxError.httpError(statusCode: http.statusCode)
    }

    do {
        return try JSONDecoder().decode(Response.self, from: data)
    } catch {
        throw FluxError.decodingError(error)
    }
}

public func sendPUT<Body: Encodable, Response: Decodable>(
    url: URL,
    body: Body,
    as type: Response.Type = Response.self,
    headers: [String: String] = [:]
) async throws -> Response {
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

    do {
        request.httpBody = try JSONEncoder().encode(body)
    } catch {
        throw FluxError.encodingError(error)
    }

    let (data, response) = try await URLSession.shared.data(for: request)

    if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
        throw FluxError.httpError(statusCode: http.statusCode)
    }

    do {
        return try JSONDecoder().decode(Response.self, from: data)
    } catch {
        throw FluxError.decodingError(error)
    }
}

public func sendPATCH<Body: Encodable, Response: Decodable>(
    url: URL,
    body: Body,
    as type: Response.Type = Response.self,
    headers: [String: String] = [:]
) async throws -> Response {
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

    do {
        request.httpBody = try JSONEncoder().encode(body)
    } catch {
        throw FluxError.encodingError(error)
    }

    let (data, response) = try await URLSession.shared.data(for: request)

    if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
        throw FluxError.httpError(statusCode: http.statusCode)
    }

    do {
        return try JSONDecoder().decode(Response.self, from: data)
    } catch {
        throw FluxError.decodingError(error)
    }
}

public func sendDELETE(
    url: URL,
    headers: [String: String] = [:]
) async throws {
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

    let (_, response) = try await URLSession.shared.data(for: request)

    if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
        throw FluxError.httpError(statusCode: http.statusCode)
    }
}

public func sendDELETE<Response: Decodable>(
    url: URL,
    as type: Response.Type,
    headers: [String: String] = [:]
) async throws -> Response {
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
        throw FluxError.httpError(statusCode: http.statusCode)
    }
    
    do {
        return try JSONDecoder().decode(Response.self, from: data)
    } catch {
        throw FluxError.decodingError(error)
    }
}
