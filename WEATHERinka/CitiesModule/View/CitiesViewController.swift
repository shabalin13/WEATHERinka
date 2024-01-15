//
//  CitiesViewController.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

import UIKit

class CitiesViewController: UIViewController {
    
    private var viewModel: CitiesViewModelProtocol
    
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
        view.backgroundColor = .yellow
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(comeBackFromCities))
    }
    
    @objc func comeBackFromCities() {
        viewModel.comeBackFromCities()
    }
    
    deinit {
        print("CitiesViewController deinit")
    }

}
