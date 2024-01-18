//
//  CitiesViewController.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

import UIKit
import RxSwift

class CitiesViewController: UIViewController {
    
    private var viewModel: CitiesViewModelProtocol
    private let disposeBag = DisposeBag()
    
    private lazy var searchController = UISearchController(searchResultsController: SearchResultsViewController())
    
    init(viewModel: CitiesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func subscribe() {
        viewModel.cityItems.subscribe(onNext: { cityItems in
            self.updateSearchResultsController(cityItems: cityItems)
        })
        .disposed(by: disposeBag)
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupSearchController()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Weather"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(comeBackFromCities))
    }
    
    private func setupSearchController() {
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a city or airport"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func updateSearchResultsController(cityItems: CityItems) {
        if let searchResultsController = searchController.searchResultsController as? SearchResultsViewController {
            searchResultsController.updateView(cityItems: cityItems)
        }
    }
    
    // MARK: - Routing
    @objc func comeBackFromCities() {
        viewModel.comeBackFromCities()
    }
    
    deinit {
        print("CitiesViewController deinit")
    }

}

extension CitiesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let cityNameToAutocomplete = searchController.searchBar.text, !cityNameToAutocomplete.isEmpty {
            print(cityNameToAutocomplete)
            viewModel.getCitiesInfo(cityNameToAutocomplete: cityNameToAutocomplete)
        } else if let searchResultsController = searchController.searchResultsController as? SearchResultsViewController {
            searchResultsController.updateView(cityItems: [])
        }
    }
    
}
