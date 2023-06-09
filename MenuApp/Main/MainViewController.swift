//
//  ViewController.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    
     var model: Results<ModelMain>!
    
    private var ascendingSorted = true
    
    private lazy var reversedSortingButton = UIBarButtonItem(image: UIImage(named: "AZ"), style: .done, target: self, action: #selector(reversedSorting))
    
    private lazy var segmentedControl = CustomizableSegmentControl(items: PresentStyle.allCases.map { $0.text.capitalized })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        model = realm.objects(ModelMain.self)
        setupConstraints()
        navigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        
        segmentedControl.tapAction =  { [weak self] in
            guard let self = self else {return}
            self.sortSelection()
        }
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(pushNewPlace))
        
        navigationItem.leftBarButtonItem = reversedSortingButton
    }

    
    private func setupConstraints() {
        
        view.addSubViews(tableView, segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            segmentedControl.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func pushNewPlace() {
        let vc = PlaceViewController()
        vc.delegat = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func reversedSorting() {
        
        ascendingSorted.toggle()
        
        if ascendingSorted {
            reversedSortingButton.image = UIImage(named: "AZ")
        } else {
            reversedSortingButton.image = UIImage(named: "ZA")
        }
        
        sorting()
    }
    
    private func sortSelection(){
       
    sorting()
   }
    
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            model = model.sorted(byKeyPath: "date", ascending: ascendingSorted)
        } else {
            model = model.sorted(byKeyPath: "name", ascending: ascendingSorted)
        }
         tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.isEmpty ? 0 : model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        let place = model[indexPath.row]

        cell.localLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.nameRestLabel.text = place.name
        cell.imageViewRest.image = UIImage(data: place.imageData!)//??

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = model[indexPath.row]
            StorageManger.deleteObject(place)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = model[indexPath.row]
        let placeVC = PlaceViewController()
        placeVC.currentPlace = place
        navigationController?.pushViewController(placeVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
}

extension MainViewController: PlaceViewControllerProtocol {
    func newPlace(name: String, location: String?, type: String?, image: UIImage?, restorantImage: String?) {
        //TODO: - refactoring
        tableView.reloadData()
    }
}

