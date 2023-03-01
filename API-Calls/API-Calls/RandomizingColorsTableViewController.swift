//
//  RandomizingColorsTableViewController.swift
//  API-Calls
//
//  Created by student on 3/1/23.
//

import UIKit

class RandomizingColorsTableViewController: UITableViewController {
    
    var searchResponse: SearchResponse?
    /// This string is not defined in any storyboard/xib. You can change this string to virtually anything and still have a functioning program.
    private static let randomColorsCellReuseIdentifier = "thisCanBeAnythingReally;it'sNotDefinedInAStoryboardOrWherever"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RandomColorsTableViewCell.self, forCellReuseIdentifier: RandomizingColorsTableViewController.randomColorsCellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        makeAPICall { searchResponse in
            self.searchResponse = searchResponse
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchResponse?.Search[indexPath.row].title
        //guard let cell = tableView.dequeueReusableCell(
        //    withIdentifier: RandomizingColorsTableViewController.randomColorsCellReuseIdentifier,
            //for: indexPath
        //) as? RandomColorsTableViewCell
        //else { return UITableViewCell() }

        //cell.updateColors()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func makeAPICall(completion: @escaping (SearchResponse?) -> Void) {
        print("Start API Call")
        let domain = "https://www.omdbapi.com/"
        let apiKey = "70a93cc6"
        let searchQuery = "Blade%20Runner"
        guard let url = URL(string: "\(domain)?apikey=\(apiKey)&s=\(searchQuery)") else {
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
            if let data = data,
               let response = try? JSONDecoder().decode(SearchResponse.self, from: data){
                print("success")
                searchResponse = response
            }
            else{
                print("Something is wrong with decoding, probably")
            }
        }
        task.resume()
    }
    struct SearchResponse: Codable {
        let totalResults: String
        let Response: String
        let Search: [Movie]
    }
    struct Movie: Codable {
        let title: String
        let year: String
        let imdbID: String
        let type: String
        let poster: String
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case imdbID
            case type = "Type"
            case poster = "Poster"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try container.decode(String.self, forKey: .title)
            self.year = try container.decode(String.self, forKey: .year)
            self.imdbID = try container.decode(String.self, forKey: .imdbID)
            self.type = try container.decode(String.self, forKey: .type)
            self.poster = try container.decode(String.self, forKey: .poster)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.Search.count ?? 0
    }
}
