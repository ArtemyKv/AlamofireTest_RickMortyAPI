//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Artem Kvashnin on 16.02.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let networkManager = NetworkManager.shared
    
    var characters: [Character] = []
    
    var nextPage = 1
    var pages = 0
    var isWaitingForNextPage = true
    
    var listView: ListView! {
        guard isViewLoaded else { return nil }
        return (view as! ListView)
    }
    
    var tableView: UITableView! {
        return listView.tableView
    }
    
    override func loadView() {
        let view = ListView()
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rick and Morty Characters"
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        getCharacters()
    }
    
    func getCharacters() {
        networkManager.fetchCharacters(page: nextPage) { response, error in
            if let response {
                self.nextPage += 1
                self.pages = response.pages
                self.characters += response.results
                self.isWaitingForNextPage = true
                self.tableView.reloadData()
            }
            
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseIdentifier) as! ListCell
        
        let character = characters[indexPath.row]
        
        cell.titleLabel.text = character.name
        cell.subtitleLabel.text = character.species
        cell.photoView.image = UIImage(systemName: "arrow.down.doc")
        
        networkManager.fetchImage(from: character.imageURL) { image in
            guard let image else { return }
            cell.photoView.image = image
        }
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count - 1 {
            self.isWaitingForNextPage = false
            getCharacters()
        }
    }
}

