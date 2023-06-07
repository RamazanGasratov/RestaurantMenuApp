//
//  ViewController.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var model = ModelMain.getPlaces()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        navigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
//        UIFont.familyNames.forEach ({
//                  print($0)
//                  UIFont.fontNames(forFamilyName: $0).forEach ({ name in
//                       print("       " + name)
//                   })
//               })

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
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        cell.localLabel.text = model[indexPath.row].location
        cell.typeLabel.text = model[indexPath.row].type
        cell.nameRestLabel.text = model[indexPath.row].name
        cell.imageViewRest.image = UIImage(named: model[indexPath.row].image)
        cell.imageViewRest.layer.cornerRadius = cell.imageViewRest.frame.size.height / 2
        cell.imageViewRest.clipsToBounds = true
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
