//
//  Assembler.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//
import Foundation
import Swinject
import RealmSwift
import Moya

extension Assembler {
    static let shared: Assembler = {
        let container = Container()
        let assembler = Assembler([
            RepositoryAssembly(),
            NetworkAssembly(),
            UseCaseAssembly(),
            FeatureAssembly()
        ], container: container)
        return assembler
    }()
}
