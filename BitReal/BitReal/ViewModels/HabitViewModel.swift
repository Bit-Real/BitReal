//
//  HabitViewModel.swift
//  BitReal
//
//  Created by Don Nguyen on 3/23/23.
//

import Foundation
import Firebase
import Combine

class HabitViewModel: ObservableObject {
    
    @Published var list = [HabitModel]()
    private var listener: ListenerRegistration?
    
    init() {
        getData()
    }
    
    deinit {
        listener?.remove()
    }
    
    func addData(uid: String, name: String, description: String, frequency: Int, alarm: String, privacy: Bool, streak: Int, progress: [Bool]) {
        let db = Firestore.firestore()
        let data = ["uid": uid,
                    "name": name,
                    "description": description,
                    "frequency": frequency,
                    "alarm": alarm,
                    "privacy": privacy,
                    "streak": streak,
                    "progress": progress,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        db.collection("habits").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added habit to Firestore")
            }
            else {
                // error handling to be added
            }
        }
    }
    
    func getData() {
        let db = Firestore.firestore()

        // Set up a snapshot listener
        listener = db.collection("habits").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
            if error == nil {
                if let snapshot = snapshot {
                    self.list = snapshot.documents.compactMap({ try? $0.data(as: HabitModel.self) })
                    self.list = self.list.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
                }
            } else {
                // handle error
            }
        }
    }
    
    func updateHabitProgress(habitId: String, dayIndex: Int, completed: Bool) {
        let db = Firestore.firestore()
        let habitRef = db.collection("habits").document(habitId)
        
        habitRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching habit document: \(error.localizedDescription)")
                return
            }
            
            guard let document = documentSnapshot else {
                print("Habit document not found")
                return
            }
            
            guard var progress = document.get("progress") as? [Bool] else {
                print("Error retrieving progress array")
                return
            }
            
            progress[dayIndex] = completed
            habitRef.updateData(["progress": progress]) { error in
                if let error = error {
                    print("Error updating habit progress: \(error.localizedDescription)")
                } else {
                    print("Habit progress updated successfully")
                }
            }
        }
    }

}

