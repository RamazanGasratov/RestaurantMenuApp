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
         "Kitchen", "Bonsai", "Вкусочка", "Индокитай", "Sultan Burger", "Speak Easy", "Классик", "Националь", "Вкусные истории", "Асса", "Рандеву"]
    

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
        if let titleFont = UIFont(name: "SnellRoundhand", size: 24) {
            let titleAttributes = [NSAttributedString.Key.font: titleFont]
            navigationController?.navigationBar.titleTextAttributes = titleAttributes
        } else {
            print("Ошибка: Невозможно создать шрифт")
        }
        self.navigationItem.title = "My Places"
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
        cell.imageView?.image = UIImage(named: restaurantNames[indexPath.row])
        cell.imageView?.layer.cornerRadius = cell.frame.size.height / 2
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
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
