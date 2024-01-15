//
//  WeatherViewController.swift
//  WEATHERinka
//
//  Created by DIMbI4 on 15.01.2024.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var viewModel: WeatherViewModelProtocol
    
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.star"), style: .plain, target: self, action: #selector(goToCities))
    }
    
    @objc func goToCities() {
        self.viewModel.goToCities()
    }
    
    deinit {
        print("WeatherViewController deinit")
    }

}
