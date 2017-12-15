//
//  AddressDataManager.swift
//  Salony
//
//  Created by Vahagn Gevorgyan on 12/14/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import Foundation
import GoogleMaps

/*
 This class is fetching data for "Address" classes,
 for now only from backend, but in future this class will also handle
 comunication with local database
 */
class AddressDataManager: Network {
    
    
    func fetchData(coordinate: CLLocationCoordinate2D?, completion: @escaping (ModelAddress?, [String]?) -> Void) {
        var address: ModelAddress?
        var areas: [ModelArea]?
        
        let group = DispatchGroup()
        group.enter()
        fetchAreas { (areasData) in
            areas = areasData
            group.leave()
        }
        if let coordinate = coordinate {
            group.enter()
            fetchAddressInfo(coordinate: coordinate) { (addressData) in
                address = addressData
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            if let id = address?.areaID, let areas = areas, address != nil {
                address!.area = self?.findAreaWithID(id: id, areas: areas)
            }
            completion(address, self?.fetchNamesFromModelAreas(areas: areas))
        }
    }
    
    /// download areas and pass to AddressTableViewController
    private func fetchAreas(completion: @escaping ([ModelArea]?) -> Void) {
        request(APIEndpoints.areas, method: .Get) { (success, data, response) in
            guard let data = data, success else {
                // TODO: - create error handling
                completion(nil)
                return
            }
            do {
                let areas = try JSONDecoder().decode([String: [ModelArea]].self, from: data)
                
                completion(areas["areas"])
            } catch let error {
                completion(nil)
                print("Error: \(error) - \(#line, #function, #file)")
                // TODO: - create error handling
            }
        }
    }
    
    private func fetchAddressInfo(coordinate:  CLLocationCoordinate2D, completion: @escaping (ModelAddress?) -> Void) {
        let addressParameter = parameterBuilder.addressParameter(coordinate: coordinate)
        request(APIEndpoints.userAddress, method: .Get, parameters: addressParameter) { (success, data, response) in
            guard let data = data, success else {
                // TODO: - create error handling
                completion(nil)
                return
            }
            do {
                let address = try JSONDecoder().decode([String: ModelAddress].self, from: data)
                completion(address["address"])
            } catch let error {
                
                completion(nil)
                print("Error: \(error) - \(#line, #function, #file)")
            }
        }
    }
    
    private func findAreaWithID(id: Int, areas: [ModelArea]) -> String? {
        return areas.filter { $0.id == id }.first?.name
    }
    
    // TODO: - create test for this method
    
    /// Fetching areas names from Json dictionary
    ///
    /// - Parameter areas: dictionary ["areas" : [ModelArea]]
    private func fetchNamesFromModelAreas(areas: [ModelArea]?) -> [String]? {
        guard let areas = areas else { return nil }
        var areasArray = [String]()
            areas.forEach { if let name = $0.name { areasArray.append(name) }  }
        return areasArray
    }
}
