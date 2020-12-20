//
//  CoreDataManager.swift
//  API_Test
//
//  Created by Seok on 2020/10/27.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    let modelName: String = "Review"
    
    func fetch(ascending: Bool = false) -> [Review] {
        var models: [Review] = [Review]()
        
        if let context = context {
            let dateSort: NSSortDescriptor = NSSortDescriptor(key: "date", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [dateSort]
            
            do {
                if let fetchRequest: [Review] = try context.fetch(fetchRequest) as? [Review] {
                    models = fetchRequest
                }
            } catch let error as NSError {
                print("could not fetch: \(error)")
            }
        }
        
        return models
    }
    
    func fecthByMovieName(movieName: String, ascending: Bool = false) -> [Review] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(movieName: movieName)
        do {
            if let results: [Review] = try context?.fetch(fetchRequest) as? [Review] {
                return results
            }
        } catch let error as NSError {
            print("could not delete memo: \(error)")
        }
    }
    
    func saveMemo(id: Int32, movieName: String, content: String, stars: Int32) {
        if let context = context, let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            if let review: Review = NSManagedObject(entity: entity, insertInto: context) as? Review {
                review.id = id
                review.movieName = movieName
                review.date = Date()
                review.name = Constants.name
                review.imageUrl = Constants.profileImageUrl?.absoluteString
                review.stars = stars
                review.content = content
                contextSave()
            }
        }
    }
    
    func deleteMemo(id: Int32) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        
        do {
            if let results: [Review] = try context?.fetch(fetchRequest) as? [Review] {
                if results.count > 0 {
                    context?.delete(results.first!)
                }
            }
        } catch let error as NSError {
            print("could not delete memo: \(error)")
        }
        
        contextSave()
    }
    
    func updateMemo(id: Int32, title: String, content: String, image: Data?) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        
        do {
            if let results: [Review] = try context?.fetch(fetchRequest) as? [Review] {
                results[0].setValue(title, forKey: "title")
                results[0].setValue(content, forKey: "content")
                results[0].setValue(image, forKey: "image")
            }
        } catch let error as NSError {
            print("could not update memo: \(error)")
        }
        
        contextSave()
    }

    
}

extension CoreDataManager {
    fileprivate func filteredRequest(id: Int32) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }
    
    fileprivate func filteredRequest(movieName: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "movieName = %@", NSString(string: movieName))
        return fetchRequest
    }
    
    fileprivate func contextSave() {
        do {
            try context?.save()
        } catch let error as NSError {
            print("Could not save🥶: \(error), \(error.userInfo)")
        }
    }
}
