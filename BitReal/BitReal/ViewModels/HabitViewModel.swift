//
//  HabitViewModel.swift
//  BitReal
//
//  Created by Don Nguyen on 3/23/23.
//

import Foundation
import Firebase

class HabitViewModel: ObservableObject {
    
    @Published var list = [HabitModel]()
    
    func addData(uid: String, name: String, description: String, frequency: Int, alarm: Date, privacy: Bool, streak: Int) {
        let db = Firestore.firestore()
        db.collection("habits").addDocument(data: ["uid": uid, "name": name, "description": description, "frequency": frequency, "alarm": alarm, "privacy": privacy, "streak": streak]) { error in
            
            if error == nil {
                self.getData()
            }
            else {
                //self.getData()
                // error handling to be added
            }
        }
        
    }
    
    func getData() {
        let db = Firestore.firestore()
//        access document for a specific user NOT SURE IF IT'S WORKING
        db.collection("habits").whereField("uid", isEqualTo:Auth.auth().currentUser!.uid).getDocuments{ snapshot, error in

            if error == nil {
                
                if let snapshot = snapshot {
                    
                    self.list = snapshot.documents.map { d in
                        
                        return HabitModel(id: d.documentID,
                                          uid: d["uid"] as? String ?? "",
                                          name: d["name"] as? String ?? "",
                                          description: d["description"] as? String ?? "",
                                          frequency: d["frequency"] as? Int ?? 0,
                                          alarm: d["alarm"] as? Date ?? Date(),
                                          privacy: d["privacy"] as? Bool ?? false,
                                          streak: d["streak"] as? Int ?? 0)
                        
                    }
                }
            }
            else {
                
            }
        }
    }
}

