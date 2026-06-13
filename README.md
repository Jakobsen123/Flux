# Flux

### Lightweight package to simplify API CRUD calls in Swift

### Current methods supported: 
```
GET
```

* Example
```Swift
struct Post: Decodable {
    let id: Int
    let title: String
}
let post = try await sendGET(url: URL(string: "https://example.com/api/post/1")!, as: Post.self)
```
