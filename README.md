# iDonateAlert
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-4-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

iDonateAlert iOS SDK to show donation alerts easily in your app.

## Examples
<p align="center">
  <img alt="UI" src="Docs/screenshot_dark.png">
  <img alt="UI" src="Docs/screenshot_light.png">
</p>


## Requirements
* iOS 11.0+
* Xcode 14+
* Swift 5.7+

## Installation
iDonateAlert is distributed with [Swift Package Manager](https://swift.org/package-manager/). You can add framework to your project from Xcode's `File > Swift Packages > Add Package Dependency` menu with its github URL:
```
https://github.com/mobven/iDonateAlert.git
```

## Usage
### Default initializer
iDonateAlert can be initialized through, which has default title and message those are presented in the screenshot above.
```swift
let alert = iDonateAlert()
alert.present(over: self)
```

### Custom title, message and icon
If you want to use custom title and message, you can use below initializer. You can pass `icon` to use custom icon.    
```swift 
let alert = iDonateAlert(title: "Donate", message: "Donation lorem impsum...")
alert.present(over: self)
```

### Attributed title and message, and custom icon
You can use `.init(attributedTitle:, attributedMessage:)` to use attributed parameters for title and messages including your own fonts. 
```swift    
let attributedTitle = NSAttributedString(string: "Donate")
let attributedMessage = NSAttributedString(string: "Donation lorem impsum...")
let alert = iDonateAlert(attributedTitle: attributedTitle, attributedMessage: attributedMessage)
alert.present(over: self)
```

### Custom Action Buttons
By default it has, AHBAP, AFAD and Turk Kizilayi buttons. If you want to add custom buttons, you can set it via:
```swift
let alert = iDonateAlert()
alert.removeAllActions()
alert.addAction(
    .init(
        title: "INDIVIDUAL DONATION", image: nil,
        borderColor: UIColor.systemPink, backgroundColor: UIColor.white,
        url: URL(string: "https://www.afad.gov.tr/depremkampanyasi2")!
    )
)
alert.present(over: self)
```

### Localization
You can pass `iDonateAlertLocale` value to it's initializer to set locale.
```swift
let alert = iDonateAlert(locale: .en)
```
Currently, English and Turkish languages are supported. Please feel free to contribute to add other languages.

## Contributors ✨

Thanks goes to these wonderful people ([emoji meanings](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Rashidium"><img src="https://avatars.githubusercontent.com/u/11058743?v=4?s=100" width="100px;" alt="Rashid Ramazanov"/><br /><sub><b>Rashid Ramazanov</b></sub></a><br /><a href="https://github.com/mobven/iDonateAlert/commits?author=Rashidium" title="Code">💻</a> <a href="https://github.com/mobven/iDonateAlert/commits?author=Rashidium" title="Documentation">📖</a> <a href="#infra-Rashidium" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="#mentoring-Rashidium" title="Mentoring">🧑‍🏫</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/NOTB4D"><img src="https://avatars.githubusercontent.com/u/75912206?v=4?s=100" width="100px;" alt="Eser Kucuker"/><br /><sub><b>Eser Kucuker</b></sub></a><br /><a href="https://github.com/mobven/iDonateAlert/commits?author=NOTB4D" title="Code">💻</a> <a href="https://github.com/mobven/iDonateAlert/commits?author=NOTB4D" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Pessevmeyen"><img src="https://avatars.githubusercontent.com/u/97690923?v=4?s=100" width="100px;" alt="Furkan Erucar"/><br /><sub><b>Furkan Erucar</b></sub></a><br /><a href="https://github.com/mobven/iDonateAlert/commits?author=Pessevmeyen" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/MobvenSametOgutcuoglu"><img src="https://avatars.githubusercontent.com/u/108695720?v=4?s=100" width="100px;" alt="Samet Ögütcüoğlu"/><br /><sub><b>Samet Ögütcüoğlu</b></sub></a><br /><a href="https://github.com/mobven/iDonateAlert/commits?author=MobvenSametOgutcuoglu" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

---
Developed with 🖤 at [Mobven](https://mobven.com/)
