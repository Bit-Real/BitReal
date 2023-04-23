//
//  HabitViewModel.swift
//  BitReal
//
//  Created by Don Nguyen on 3/23/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var list = [HabitModel]()
    private var listener: ListenerRegistration?
    
    init() {
        getData { success in
            self.checkProgress()
        }
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
                    "timestamp": Timestamp(date: Date()),
                    "nextSundayDate": nextSunday()] as [String : Any]
        db.collection("habits").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added habit to Firestore")
            }
            else {
                // error handling to be added
            }
        }
    }
    
    func getData(completion: @escaping(Bool) -> Void) {
        let db = Firestore.firestore()

        // Set up a snapshot listener
        listener = db.collection("habits").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
            if error == nil {
                if let snapshot = snapshot {
                    self.list = snapshot.documents.compactMap({ try? $0.data(as: HabitModel.self) })
                    self.list = self.list.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
                    completion(true)
                }
            } else {
                // handle error
            }
        }
    }
    
    func updateHabitProgress(habitID: String, dayIndex: Int, completed: Bool) {
        let db = Firestore.firestore()
        let habitRef = db.collection("habits").document(habitID)
        
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
    
    func resetHabitProgress(habitID: String) {
        let db = Firestore.firestore()
        let habitRef = db.collection("habits").document(habitID)
        
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
            
            // create a new progress array and overwrite the old one
            progress = Array(repeating: false, count: 7)
            habitRef.updateData(["progress": progress]) { error in
                if let error = error {
                    print("Error updating habit progress: \(error.localizedDescription)")
                } else {
//                    print("Habit progress updated successfully")
                }
            }
            
        }
    }
    
    func assignNewSunday(habitID: String) {
        let db = Firestore.firestore()
        let habitRef = db.collection("habits").document(habitID)
        let newTimestamp = nextSunday()
        
        habitRef.updateData([
            "nextSundayDate": newTimestamp
        ]) { err in
            if let err = err {
                print("Error updating habit timestamp: \(err)")
            } else {
//                print("Habit timestamp updated successfully")
            }
        }
    }
    
    func nextSunday() -> Timestamp {
        let calendar = Calendar.current
        let today = Date()
        let components = DateComponents(weekday: 1)
        guard let sunday = calendar.nextDate(after: today, matching: components, matchingPolicy: .nextTime) else {
            fatalError("Could not calculate next Sunday")
        }
        return Timestamp(date: sunday)
    }
    
    func getHabitNextSunday(habitID: String, completion: @escaping(Timestamp) -> Void) {
        let db = Firestore.firestore()
        let habitRef = db.collection("habits").document(habitID)
        habitRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching habit document: \(error.localizedDescription)")
                return
            }
            
            guard let document = documentSnapshot else {
                print("Habit document not found")
                return
                
            }
            let nextSundayDate = document.get("nextSundayDate") as! Timestamp
            completion(nextSundayDate)
        }
    }
    
    func checkProgress() {
        let currentDate = Timestamp(date: Date())
//        print("Current date: \(currentDate.dateValue())")
        for i in 0 ..< self.list.count {
//            print("Entered loop at index: \(i)")
            getHabitNextSunday(habitID: list[i].id ?? "") { nextSundayDate in
//                print("habit's next sunday: .\(nextSundayDate.dateValue())")
                if currentDate.dateValue() > nextSundayDate.dateValue() {
//                    print("Current date is past next Sunday")
                    self.resetHabitProgress(habitID: self.list[i].id ?? "")
                    self.assignNewSunday(habitID: self.list[i].id ?? "")
                }
            }
        }
    }

}

