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
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("habits").getDocuments { snapshot, error in
            
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    self.list = snapshot.documents.map { d in
                        
                        return HabitModel(id: d.documentID,
                                          uid: d["uid"] as? String ?? "",
                                          name: d["name"] as? String ?? "",
                                          description: d["description"] as? String ?? "",
                                          frequency: d["frequency"] as? Int ?? 0,
                                          alarm: d["alarm"] as? String ?? "None",
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

