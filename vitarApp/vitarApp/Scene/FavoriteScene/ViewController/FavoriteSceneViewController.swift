//
//  FavoriteSceneViewController.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 15.12.2022.
//

import UIKit


class FavoriteSceneViewController: UIViewController {
    
    
    @IBOutlet private weak var favoriteListTableView: UITableView!{
        didSet{
            favoriteListTableView.delegate = self
            favoriteListTableView.dataSource = self
            favoriteListTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteCell")
            favoriteListTableView.rowHeight = 150.0
        }
    }
    
    private var viewModel: FavoriteSceneViewModelProtocol = FavoriteSceneViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchFavoriteGames()
        Globals.sharedInstance.isFavoriteChanged = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Globals.sharedInstance.isFavoriteChanged{
            viewModel.fetchFavoriteGames()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "FavoritetoDetail":
            if let gameId = sender as? Int{
                let goalVC = segue.destination as! GameDetailSceneViewController
                goalVC.gameId = gameId
                goalVC.delegateFavorite = self
            }
        default:
            print("identifier not found")
        }
    }
    
}



extension FavoriteSceneViewController: FavoriteSceneViewModelDelegate {
    func favoritesLoaded() {
        favoriteListTableView.reloadData()
    }
}


extension FavoriteSceneViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell,
              let obj = viewModel.getGame(at: indexPath.row) else {return UITableViewCell()}
        DispatchQueue.main.async {
            cell.configureCell(obj)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let gameId = viewModel.getGameId(at: indexPath.row){
            performSegue(withIdentifier: "FavoritetoDetail", sender: gameId)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("REMOVE_FAVORITE", comment: "Remove Favorite")){ (contextualAction, view, bool ) in
            self.viewModel.removeGame(at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}