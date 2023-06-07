//
//  ViewController.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    
    let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Вкусочка", "Индокитай", "Sultan Burger", "Speak Easy", "Классик", "Националь", "Вкусные истории", "Асса", "Рандеву"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        navigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    private func navigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Cell"
    }

    
    private func setupConstraints() {
        
        view.addSubViews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)
        cell.textLabel?.text = restaurantNames[indexPath.row]
        
        return cell
    }
    
}

extension UIView {
    
    func addSubViews(_ views: UIView...){
        views.forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
}
