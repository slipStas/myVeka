//
//  FriendsRealm.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 02.03.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import RealmSwift

class FriendRealm: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var id = 0
    
    func saveFriends(_ friends : [FriendRealm]) {
        do {
        // получаем доступ к хранилищу
            let realm = try Realm()
                    
        // начинаем изменять хранилище
            realm.beginWrite()
                    
        // кладем все объекты класса погоды в хранилище
            realm.add(friends)
                    
        // завершаем изменения хранилища
            try realm.commitWrite()
        } catch {
        // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
}
