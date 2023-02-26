//
//  NetworkManager.swift
//  H4X0RNews
//
//  Created by Mateo Ortiz on 26/02/23.
//

import Foundation


class NetworkManager: ObservableObject {
    
    @Published var posts: [Post] = []
    
    func fetchPosts() {
       let urlString = "https://hn.algolia.com/api/v1/search?tags=front_page"
       
       request(with: urlString, completion: {(response: PostData?, error) in
           if let error = error {
               print(error.localizedDescription)
               return
           }
           
           if let responseHits = response {
               self.posts = responseHits.hits
           }
       })
       
   }
    
    func request<T: Decodable>(with urlString: String, completion: @escaping (T?, Error?) -> Void) {
            
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                DispatchQueue.main.async {
                    if let error = error {
                        completion(nil, error)
                    }
                    
                    if let safeData = data {
                        do {
                            let resultDecoded = try JSONDecoder().decode(T.self, from: safeData)
                            completion(resultDecoded, nil)
                        } catch let decodeError  {
                            completion(nil, decodeError)
                        }
                    }
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
}
