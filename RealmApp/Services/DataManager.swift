//
//  DataManager.swift
//  RealmApp
//
//  Created by Vsevolod Lashin on 23.05.2023.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    private let storageManager = StorageManager.shared
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        let shoppingList = TaskList()
        shoppingList.title = "Shopping List"
        
        let moviesList = TaskList(
            value: [
                "Movies List",
                Date(),
                [
                    ["Best film ever"] as [Any],
                    ["The best of the best", "Must have", Date(), true]
                ]
            ] as [Any]
        )
        
        let milk = Task()
        milk.title = "Milk"
        milk.note = "2L"
        
        let apples = Task(value: ["Apples", "2Kg"])
        let bread = Task(value: ["title": "Bread", "isComplete": true] as [String : Any])
        
        shoppingList.tasks.append(milk)
        shoppingList.tasks.insert(contentsOf: [apples, bread], at: 1)
        
        DispatchQueue.main.async { [unowned self] in
            storageManager.save([shoppingList, moviesList])
            completion()
        }
    }
}
