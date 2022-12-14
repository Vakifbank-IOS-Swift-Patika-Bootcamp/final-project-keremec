//
//  SearchSceneViewController.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 14.12.2022.
//

import UIKit

class SearchSceneViewController: UIViewController {

    @IBOutlet private weak var gameListTableView: UITableView!{
        didSet{
            gameListTableView.delegate = self
            gameListTableView.dataSource = self
            gameListTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
            gameListTableView.rowHeight = 150.0
        }
    }
    @IBOutlet private weak var searchBar: UISearchBar!{
        didSet{
            searchBar.delegate = self
        }
    }
    
    
    private var viewModel: HomeSceneViewModelProtocol = HomeSceneViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    

}


extension SearchSceneViewController: HomeSceneViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
    }
}


extension SearchSceneViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell,
              let obj = viewModel.getGame(at: indexPath.row) else {return UITableViewCell()}
        DispatchQueue.main.async {
                cell.configureCell(obj)
        }
        return cell
    }
    
}

//MARK: - Searchbar Action

extension SearchSceneViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            print(text)
            viewModel.searchGames(text)
            self.view.endEditing(true)
        }
    }
    
}
//MARK: -
