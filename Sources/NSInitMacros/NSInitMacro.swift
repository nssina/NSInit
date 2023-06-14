//
//  NSInitMacro.swift
//  NSInit
//
//  Created by Sina Rabiei on 6/14/23.
//  Copyright 2023 Sina Rabiei. All rights reserved.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `NSInitMacro` macro, which takes class or struct
/// parameters and produces an initializer containing all of the given parameters. For example,
///
///     @NSInit
///     struct City {
///         var name: String
///         var population: Int
///         var country: String
///         var location: CLLocation
///     }
///
///  will expand to
///
///     init(name: String, population: Int, country: String, location: CLLocation) {
///         self.name = name
///         self.population = population
///         self.country = country
///         self.location = location
///     }
public struct NSInitMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        var initializer: InitializerDeclSyntax?
        
        if let structDecl = declaration.as(StructDeclSyntax.self) {
            initializer = buildStructInit(declaration: structDecl)
        } else if let classDecl = declaration.as(ClassDeclSyntax.self) {
            initializer = buildClassInit(declaration: classDecl)
        } else {
            throw NSInitError.onlyApplicableToStructOrClass
        }
        
        guard let unwrappedInitializer = initializer else {
            throw NSInitError.unableToBuildInit
        }
        
        return [DeclSyntax(unwrappedInitializer)]
    }
    
    // MARK: - Build init for class
    private static func getClassInfo(declaration: ClassDeclSyntax) -> (name: [PatternSyntax], type: [TypeSyntax]) {
        let members = declaration.memberBlock.members
        let varDecl = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
        let varName = varDecl.compactMap { $0.bindings.first?.pattern }
        let varType = varDecl.compactMap { $0.bindings.first?.typeAnnotation?.type }
        
        return (varName, varType)
    }
    
    private static func buildClassInit(declaration: ClassDeclSyntax) -> InitializerDeclSyntax? {
        let info = getClassInfo(declaration: declaration)
        var initialCode: String = "init("
        for (name, type) in zip(info.name, info.type) {
            initialCode += "\(name): \(type), "
        }
        initialCode = String(initialCode.dropLast(2))
        initialCode += ")"
        let header = PartialSyntaxNodeString(stringLiteral: initialCode)
        
        let initializer = try? InitializerDeclSyntax(header) {
            for name in info.name {
                ExprSyntax("self.\(name) = \(name)")
            }
        }
        
        return initializer
    }
    
    // MARK: - Build init for struct
    private static func getStructInfo(declaration: StructDeclSyntax) -> (name: [PatternSyntax], type: [TypeSyntax]) {
        let members = declaration.memberBlock.members
        let varDecl = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
        let varName = varDecl.compactMap { $0.bindings.first?.pattern }
        let varType = varDecl.compactMap { $0.bindings.first?.typeAnnotation?.type }
        
        return (varName, varType)
    }
    
    private static func buildStructInit(declaration: StructDeclSyntax) -> InitializerDeclSyntax? {
        let info = getStructInfo(declaration: declaration)
        var initialCode: String = "init("
        for (name, type) in zip(info.name, info.type) {
            initialCode += "\(name): \(type), "
        }
        initialCode = String(initialCode.dropLast(2))
        initialCode += ")"
        let header = PartialSyntaxNodeString(stringLiteral: initialCode)
        
        let initializer = try? InitializerDeclSyntax(header) {
            for name in info.name {
                ExprSyntax("self.\(name) = \(name)")
            }
        }
        
        return initializer
    }
}

@main
struct NSInitPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        NSInitMacro.self
    ]
}
