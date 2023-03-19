//
//  APIViewController.swift
//  Lab2-Echon
//
//  Created by Carlo Echon on 3/19/23.
//

import UIKit

class APIViewController: UITableViewController {
    var searchResponse: SearchResponse?
    private static let APICallCellReuseIdentifier = "gibberish"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(APIViewCell.self, forCellReuseIdentifier: APIViewController.APICallCellReuseIdentifier)
        
        makeAPICall { searchResponse in
                self.searchResponse = searchResponse
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: APIViewController.APICallCellReuseIdentifier, for: indexPath) as? APIViewCell else {
            return UITableViewCell()
        }
        if let book = searchResponse?.docs[indexPath.row] {
            cell.titleLabel.text = book.name
            cell.idLabel.text = "ID: \(book._id)"
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    
    func makeAPICall(completion: @escaping (SearchResponse?) -> Void) {
        print("Start API Call")
        let domain = "https://the-one-api.dev/v2/book"
        guard let url = URL(string: "\(domain)") else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("Done with call")
            var searchResponse: SearchResponse?
            defer { completion(searchResponse) }
            if let error = error {
                print("Error with API Call :\(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                print("Error with the response (\(String(describing: response))")
                return
            }
            if let data = data {
                print("Received data: \(String(describing: String(data: data, encoding: .utf8)))")
                if let response = try? JSONDecoder().decode(SearchResponse.self, from: data) {
                    searchResponse = response
                } else {
                    print("Something is wrong with decoding, probably")
                }
            } else {
                print("No data received")
            }
        }
        task.resume()
    }

    
    struct SearchResponse: Codable {
        let docs: [Book]
        let total: Int
        let limit: Int
        let offset: Int
        let page: Int
        let pages: Int
        
        enum CodingKeys: String, CodingKey {
            case docs
            case total
            case limit
            case offset
            case page
            case pages
        }
    }

    struct Book: Codable {
        let name: String
        let _id: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case _id = "_id"
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResponse?.docs.count ?? 0
        }
}
