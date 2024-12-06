//
//  CoreDataDatabas.swift
//  english-words
//
//  Created by Barış Dilekçi on 6.12.2024.
//

import Foundation
import CoreData

final class CoreDataDatabase : LocalDatabaseProtocol {
    
    static let shared = CoreDataDatabase()
    
    private(set) var container: NSPersistentContainer
    @Published var favoriteWords: Set<Int> = []
    
    private init() {
          container = NSPersistentContainer(name: "EnglishWord")
          container.loadPersistentStores { storeDescription, error in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          }
      }
    
      init(inMemory: Bool = false) {
          container = NSPersistentContainer(name: "english_words")
          if inMemory {
              container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
          }
          container.loadPersistentStores { storeDescription, error in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          }
      }
    
    func loadFavoriteWords() -> Set<Int> {
        let context = container.viewContext
              let request: NSFetchRequest<Item> = Item.fetchRequest()
              
              request.predicate = NSPredicate(format: "isFavorite == true")
              
              do {
                  let items = try context.fetch(request)
                  favoriteWords = Set(items.map { Int($0.id) })
                  return favoriteWords
              } catch {
                  print("Favorites fetch failed: \(error)")
                  return Set()
              }
    }
    
    func toggleFavorite(id: Int) {
        let context = container.viewContext
         let request: NSFetchRequest<Item> = Item.fetchRequest()
         request.predicate = NSPredicate(format: "id == %d", id)
         
         do {
             let items = try context.fetch(request)
             if let existingItem = items.first {
                 existingItem.isFavorite.toggle()
             } else {
                 let newItem = Item(context: context)
                 newItem.timestamp = Date()
                 newItem.id = Int16(id)
                 newItem.isFavorite = true
             }
             try context.save()
             loadFavoriteWords()
         } catch {
             print("Failed to toggle favorite: \(error)")
         }
     }
    }
    
    

