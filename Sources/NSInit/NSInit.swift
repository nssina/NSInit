// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces an initializer
/// containing all of the parameters in a class or struct. For example,
///
///     @NSInit
///     struct City {
///         var name: String
///         var population: Int
///         var country: String
///         var location: CLLocation
///     }
///
///  will produce
///
///     init(name: String, population: Int, country: String, location: CLLocation) {
///         self.name = name
///         self.population = population
///         self.country = country
///         self.location = location
///     }
@attached(member, names: named(init))
public macro NSInit() = #externalMacro(module: "NSInitMacros", type: "NSInitMacro")
