//
//  RealmRepository.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import Realm
import RxSwift

protocol AbstractRepository {
    associatedtype RealmObject
    func queryAll() -> Observable<[RealmObject]>
    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor]) -> Observable<[RealmObject]>
    func save(entity: RealmObject)
    func delete(entity: RealmObject)
}

final class RealmRepository<RealmObject: RealmRepresentable>: AbstractRepository where RealmObject == RealmObject.RealmType.DomainType, RealmObject.RealmType: Object {
    
    private var disposeBag = DisposeBag()
    private var realm: Realm

    init(realm: Realm) {
        self.realm = realm
        print("relam url \(RLMRealmPathForFile("default.realm"))")
    }

    func queryAll() -> Observable<[RealmObject]> {
        let realm = self.realm
        let objects = realm.objects(RealmObject.RealmType.self)
        
        return Observable.array(from: objects)
            .mapToDomain()
    }
    
    func byPrimaryId(primaryKey: String) -> Observable<RealmObject?> {
        let realm = self.realm
        guard let object = realm.object(ofType: RealmObject.RealmType.self, forPrimaryKey: primaryKey) else {
            return Observable.just(nil)
        }
        return  Observable.from(object: object).toDomain()
    }

    func query(with predicate: NSPredicate, sortDescriptors: [NSSortDescriptor] = []) -> Observable<[RealmObject]> {
        let realm = self.realm
        let objects = realm.objects(RealmObject.RealmType.self).filter(predicate)
        return Observable.array(from: objects)
                                 .mapToDomain()
    }

    func save(entity: RealmObject) {
        Observable.from(object: entity.asRealm())
            .subscribe(realm.rx.add(update: .modified))
            .disposed(by: disposeBag)
    }
    
    func save(entities: [RealmObject]) {
        let items = entities.map { $0.asRealm() }
        Observable.from(optional: items)
            .subscribe(realm.rx.add(update: .modified))
            .disposed(by: disposeBag)
    }

    func delete(entity: RealmObject) {
        Observable.from(object: entity.asRealm())
            .subscribe(Realm.rx.delete())
            .disposed(by: disposeBag)
    }
    
    func delete(with predicate: NSPredicate) {
        let realm = self.realm
        guard let entity = realm.objects(RealmObject.RealmType.self)
            .filter(predicate).first else { return }
        safeWrite {
            realm.delete(entity)
        }
    }
    
    func deleteAll() {
        let realm = self.realm
        let objects = realm.objects(RealmObject.RealmType.self)
        self.safeWrite {
            realm.delete(objects)
        }
    }
    
    func safeWrite(_ block: (() throws -> Void)) {
        if realm.isInWriteTransaction {
            try! block()
        } else {
            try! realm.write(block)
        }
    }
}
