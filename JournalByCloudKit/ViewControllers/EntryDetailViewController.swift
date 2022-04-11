//
//  EntryDetailViewController.swift
//  JournalByCloudKit
//
//  Created by James Hager on 4/11/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextView: UITextView!
    
    // MARK: - Properties
    
    var entry: Entry?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView(with: entry)
    }

    // MARK: - View Methods
    
    func setUpView(with entry: Entry?) {
        self.entry = entry
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        textTextView.text = entry.text
    }

    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
              !title.isEmpty,
              let text = textTextView.text,
              !title.isEmpty
        else { return }
        
        if let entry = entry {
            print("\(#function) - update entry")
        } else {
            EntryController.shared.create(title: title, text: text) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let entry):
                        guard let entry = entry else { return }
                        self.setUpView(with: entry)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
