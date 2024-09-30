//
//  ChooseCityController.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 30.09.2024.
//

import UIKit

protocol ChooseCityP: AnyObject {
    func selectCity(city: CityModel?)
}

class ChooseCityController: UIViewController {
    var mainView = ChooseCityView()
    
    var cites: CountryModel? {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    weak var delegate: ChooseCityP?
    
    var origiralArray: CountryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        initViewController()
    }
    
    private func initViewController() {
        origiralArray = cites
        swipeToPop()
        registerTableView()
        addTargets()
    }
}

//MARK: - Helpers
extension ChooseCityController {
    private func swipeToPop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
    private func registerTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.registerReusableCell(ChooseCityCell.self)
    }
    
    private func addTargets() {
        mainView.textField.addTarget(self, action: #selector(filtredCities(_:)), for: .editingChanged)
        mainView.backButton.addTarget(self, action: #selector(popToMain), for: .touchUpInside)
    }
}

//MARK: - Targets
extension ChooseCityController {
    @objc private func filtredCities(_ sender: UITextField) {
        var helpedArray = origiralArray
        helpedArray?.regions.removeAll()
        if let text = sender.text, let origiralArray = origiralArray?.regions, !text.isEmpty {
            for (_, areaItem) in origiralArray.enumerated() {
                let filteredNames = areaItem.cities.filter({ $0.name.contains(text) })
                if !filteredNames.isEmpty {
                    let regionsModel = RegionModel(name: areaItem.name, cities: filteredNames)
                    helpedArray?.regions.append(regionsModel)
                }
            }
            cites = helpedArray
        } else {
            cites = origiralArray
        }
    }
    
    @objc private func popToMain() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView delegate/dataSource
extension ChooseCityController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cites?.regions[section].cities.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cites?.regions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cites?.regions[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        let model = cites?.regions[section].cities[row]
        let cell: ChooseCityCell = tableView.dequeueReusableCell(for: indexPath)
        cell.cityModel = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        let model = cites?.regions[section].cities[row]
        self.delegate?.selectCity(city: model)
    }
}
