# Flux

### Lightweight package to simplify API calls in Swift


* Example
```Swift
struct Post: Decodable {
    let id: Int
    let title: String
}
let post = try await sendGET(url: URL(string: "https://example.com/api/post/1")!, as: Post.self)
```
