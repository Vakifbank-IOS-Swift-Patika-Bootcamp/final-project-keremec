//
//  SearchSceneViewController.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 14.12.2022.
//

import UIKit

class SearchSceneViewController: UIViewController {
    
    //MARK: - Outlets and Variables
    var modalCall:Int?
    weak var delegateNote: NoteDetailSceneViewController?
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
    
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("SEARCH_PAGE", comment: "Search Games")
        viewModel.delegate = self
    }
    
    //MARK: - Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SearchtoDetail":
            if let gameId = sender as? Int{
                let goalVC = segue.destination as! GameDetailSceneViewController
                goalVC.gameId = gameId
            }
        default:
            print("identifier not found")
        }
    }
}


//MARK: - Delegate Functions
extension SearchSceneViewController: HomeSceneViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
    }
}

//MARK: - Tableview Functions
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
    // Segue Actions - Tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let modalCall{
            switch modalCall {
            case 1:
                delegateNote?.setGame(game: viewModel.getGame(at: indexPath.row))
                dismiss(animated: true)
            default:
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        if let gameId = viewModel.getGameId(at: indexPath.row){
            performSegue(withIdentifier: "SearchtoDetail", sender: gameId)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Searchbar Action

extension SearchSceneViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            viewModel.searchGames(text)
            self.view.endEditing(true)
        }
    }
    
}
//MARK: -
