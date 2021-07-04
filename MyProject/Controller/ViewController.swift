//
//  ViewController.swift
//  MyProject
//
//  Created by user199453 on 7/3/21.
//
//
import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    let spinner = UIActivityIndicatorView()
    
    
    private var items = [Item]()
    var numberOfItems = [Item](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.numberOfItems.count) Items found"
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Paxel Mini Project"
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyDataTableViewCell
        let item = numberOfItems[indexPath.row]
        cell.fullNameLabe.text = item.full_name
        cell.loginLabel.text = item.owner?.login
        cell.descriptionLabel.text = item.description
        cell.avatarDotImage.layer.cornerRadius = 10
        
        if let url = URL(string: (item.owner?.avatar_url)!) {
            if let image = try? Data(contentsOf: url) {
                cell.avatarDotImage.image = UIImage(data: image)
            }
        }
        return cell
    }
    //     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if let url = URL(string: searchResults[indexPath.row].html_url!) {
    //            let safariVC = SFSafariViewController(url: url)
    //            present(safariVC, animated: true, completion: nil)
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        _ = items[indexPath.row].html_url
        //        guard URL(string: " ") != nil else {
        //            return
        //        }
        if let url = URL(string: numberOfItems[indexPath.row].html_url!){
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
    
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        spinner.startAnimating()
        spinner.color = .black
        tableView.backgroundView = spinner
        guard let searchBarText = searchBar.text else {
            return
        }
        let itemRequest = Project(gitSearch: searchBarText)
        itemRequest.getproject { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let items):
                self?.numberOfItems = items
            }
        }
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            numberOfItems = []
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.spinner.isHidden = true
            }
        }
    }
}



