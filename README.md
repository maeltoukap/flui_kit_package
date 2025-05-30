<img src="https://raw.githubusercontent.com/maeltoukap/flui_kit_package/refs/heads/main/assets/flui_kit_logo.jpeg" alt="FLUI Kit Logo" width="200">

# FLUI Kit

A modern library of reusable components and screens for Flutter, designed to accelerate mobile application development with consistent design.

## 📦 Installation

Add this dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flui_kit: ^0.0.2+1
```

Then run:

```bash
flutter pub get
```

## 🎯 Features

- Rich collection of reusable UI components
- Pre-built screens for common use cases
- Customizable and consistent themes
- Full dark mode support
- Performance-optimized components
- Detailed documentation and usage examples

## 🛠️ Available Components

All components can be found at [FluiKit Components](https://fluikit.maeltoukap.me/components/).

### Custom Components

- Card plan switcher

## 💡 Usage

```dart
import 'package:flui_kit/flui_kit.dart';

// Button usage example
FluiButton(
  text: 'Login',
  onPressed: () {
    // Action
  },
)

// Login screen usage example
FluiLoginScreen(
  onLogin: (email, password) async {
    // Login logic
  },
)
```

## 🎨 Customization

The kit supports full customization via ThemeData:

```dart
FluiTheme(
  data: FluiThemeData(
    primaryColor: Colors.blue,
    secondaryColor: Colors.green,
    // Other configurations...
  ),
  child: YourApp(),
)
```

## 📱 Examples

Check out the `example` folder for complete implementations and use cases.

## 🤝 Contributing

Contributions are welcome! Please read our contribution guidelines for more details.

1. Fork the project
2. Create your feature branch (`git checkout -b feat/AmazingFeature`)
3. Create your fix branch (`git checkout -b fix/AmazingFeature`)
4. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
5. Push to the branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

## 📄 License

Distributed under a custom MIT License. See `LICENSE` for more information.

## 📧 Contact

For any questions or suggestions, feel free to open an issue or contact us directly.

- Email: <devmael09@gmail.com>
<!-- - Twitter: [@flui_kit](https://x.com/maeltoukap) -->
- Website: [https://fluikit.maeltoukap.me](https://fluikit.maeltoukap.me)

## Contributors

<!-- readme: collaborators,contributors -start -->
<table>
	<tbody>
		<tr>
            <td align="center">
                <a href="https://github.com/dhruvanbhalara">
                    <img src="https://avatars.githubusercontent.com/u/53393418?v=4" width="100;" alt="dhruvanbhalara"/>
                    <br />
                    <sub><b>Dhruvan Bhalara</b></sub>
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/maeltoukap">
                    <img src="https://avatars.githubusercontent.com/u/74214399?v=4" width="100;" alt="maeltoukap"/>
                    <br />
                    <sub><b>maeltoukap</b></sub>
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/YaseenHussein">
                    <img src="https://avatars.githubusercontent.com/u/138660098?v=4" width="100;" alt="YaseenHussein"/>
                    <br />
                    <sub><b>Yaseen Hussein Qasem Saeed</b></sub>
                </a>
            </td>
		</tr>
	<tbody>
</table>
<!-- readme: collaborators,contributors -end -->

---

Made with ❤️ by your team
