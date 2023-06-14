# NSInit

NSInit is a Swift package that uses Swift Macros to provide a simple way to initialize your structs or classes. It eliminates the need to repeatedly write boilerplate code when creating structs or classes.

## Installation

### Swift Package Manager

To install NSInit using Swift Package Manager, add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/nssina/NSInit.git", from: "1.0.0")
]
```

## Usage

To use NSInit, simply import the package into your code. Then, you can use the @NSInit macro to initialize your objects. For example:

```swift
import NSInit

@NSInit
class Car {
    var number: Int
    var name: String
    var model: String
    var color: String
    var size: Double
}
```

## Contributing

Contributions to NSInit are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue on the [GitHub repository](https://github.com/nssina/NSInit). Feel free to submit pull requests with improvements or fixes as well.

## License

NSInit is released under the MIT license. See the [LICENSE](https://github.com/nssina/NSInit/blob/main/LICENSE) file for more details.
