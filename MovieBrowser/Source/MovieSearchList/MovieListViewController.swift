//
//  MovieListViewController.swift
//  MovieBrowser
//
//  Created by Colin Smith on 5/3/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    var movies: [Movie] = []
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        self.movieSearchBar.delegate = self
        self.movieTableView.reloadData()
        MovieController.shared.getGenreList()
    }
    
    
    func searchMovies(searchText: String) {
        MovieController.shared.getMoviesFrom(searchTerm: searchText) { (movies) in
            self.movies = movies
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
                if movies.isEmpty {
                    self.movieTableView.isHidden = true
                } else {
                    self.movieTableView.isHidden = false
                }
            }
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let destinationVC = segue.destination as? MovieDetailViewController,
             let index = movieTableView.indexPathForSelectedRow else { return }
            destinationVC.movie = self.movies[index.row]
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieTableViewCell else { return UITableViewCell() }
        cell.movie = self.movies[indexPath.row]
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.movies.removeAll()
            self.movieTableView.reloadData()
        }
        self.searchMovies(searchText: searchText)
    }
}
