//
//  ApiService.swift
//  MyProject
//
//  Created by user199453 on 7/3/21.
//

import Foundation

enum ProjectError:Error {
    case noDataAvailable
    case canNotProcessData
}
struct Project {
    let resourceURL: URL
    init(gitSearch: String) {
        let resourceString = "https://api.github.com/search/repositories?q=\("\(gitSearch)")"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
        
    }
    func getproject(completion : @escaping (Result<[Item], ProjectError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, _) in
        guard let jsonData = data else {
            completion(.failure(.noDataAvailable))
            return
        }
        do{
            let decoder = JSONDecoder()
            let gitResponse = try decoder.decode(ProjectData.self, from: jsonData)
            let gitDetails = gitResponse.items
            completion(.success(gitDetails))
        } catch {
            completion(.failure(.canNotProcessData))
        }
            
       }
        dataTask.resume()
    }
}

