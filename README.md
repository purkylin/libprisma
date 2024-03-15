<p align="center"> 
<img width="312" alt="image" src="https://github.com/purkylin/libprisma/assets/5069285/97865494-c41b-4a4f-bb0c-1e83bc136a04">
</p>

This is a [Telegram libprisma](https://github.com/TelegramMessenger/libprisma) wrapper, you can highghlight code native with super fast speed.

## How to update languages
Generate a new dat file and replace it.

## Platform support
* iOS
* macOS
* Others(untested)

## Install
* SPM
  
```swift
dependencies: [
    .package(url: "https://github.com/purkylin/libprisma", .upToNextMajor(from: "0.1.0"))
]

```

## Usage

```swift
import libprisma

let syntaxHighlighter = Syntaxer()!
let font = UIFont.monospacedSystemFont(ofSize: 17, weight: .regular)
let theme = SyntaxterTheme(dark: false, textColor: UIColor.black, textFont: font, italicFont: font, mediumFont: font)

return syntaxHighlighter.syntax("Your code", language: lang, theme: theme)
```

