//
//  EntryListViewController.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import UIKit

class EntryListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var entryController: EntryController { EntryController.shared }
    var entries: [Entry] { EntryController.shared.entries }
    
    let cellIdentifier = "entryCell"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - View Methods
    
    func setUpViews() {
        tableView.dataSource = self
    }
    
    func loadData() {
        entryController.fetch { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetail",
              let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as? EntryDetailViewController
        else { return }
        
        destination.entry = entries[indexPath.row]
    }
    
}

// MARK: - UITableViewDataSource

extension EntryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let entry = entries[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = entry.title
        config.secondaryText = entry.timestamp.string
        cell.contentConfiguration = config
        
        return cell
    }
}
