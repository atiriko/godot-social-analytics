# Contributing to SocialAnalytics

Thank you for your interest in contributing to SocialAnalytics! This document provides guidelines and information for contributors.

## 📋 Code of Conduct

By participating in this project, you agree to maintain a respectful and collaborative environment for all contributors.

## 🚀 Getting Started

### Prerequisites

- Godot 4.x installed
- Android Studio (for Kotlin development)
- Git for version control
- Basic knowledge of GDScript and Kotlin

### Development Setup

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/your-username/godot-social-analytics.git
   cd godot-social-analytics
   ```
3. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 💡 How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](https://github.com/yourusername/godot-social-analytics/issues)
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Godot version, OS, and plugin version
   - Relevant logs or screenshots

### Suggesting Features

1. Create an issue tagged with `enhancement`
2. Describe the feature and its use case
3. Explain why it would be valuable

### Pull Requests

1. **Code Quality**
   - Follow existing code style
   - Add comments for complex logic
   - Keep functions focused and small

2. **Testing**
   - Test your changes on Android
   - Verify Firebase and TikTok integrations still work
   - Test edge cases and error handling

3. **Documentation**
   - Update README.md if adding features
   - Add code comments for public APIs
   - Update CHANGELOG.md

4. **Commit Messages**
   - Use clear, descriptive commit messages
   - Format: `type: description`
   - Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`
   - Example: `feat: add iOS support for Firebase Analytics`

5. **Pull Request Process**
   - Create PR against `main` branch
   - Provide clear description of changes
   - Link related issues
   - Wait for review and address feedback

## 🏗️ Project Structure

```
addons/SocialAnalytics/
├── bin/                        # Compiled plugin binaries
├── examples/                   # Example usage scripts
├── social_analytics_interface.gd  # GDScript API
├── social_analytics_export_plugin.gd  # Export configuration
├── plugin.cfg                  # Plugin metadata
├── README.md                   # Main documentation
├── LICENSE                     # MIT License
├── CHANGELOG.md               # Version history
└── CONTRIBUTING.md            # This file
```

Kotlin source (separate module):
```
social_analytics/
└── src/main/java/com/omega/planeats/socialanalytics/
    └── SocialAnalyticsPlugin.kt  # Android implementation
```

## 📝 Code Style Guidelines

### GDScript

- Use tabs for indentation
- Follow [GDScript style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- Add type hints: `func my_function(param: String) -> void:`
- Document public functions with comments

### Kotlin

- Use 4 spaces for indentation
- Follow [Kotlin coding conventions](https://kotlinlang.org/docs/coding-conventions.html)
- Add KDoc comments for public methods
- Use meaningful variable names

## 🧪 Testing Checklist

Before submitting a PR, verify:

- [ ] Code compiles without errors
- [ ] TikTok initialization works with dynamic credentials
- [ ] Firebase events are logged correctly
- [ ] No hardcoded credentials in source
- [ ] Error handling works properly
- [ ] Logcat shows appropriate debug messages
- [ ] README examples work without modification
- [ ] No new compiler warnings

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🤝 Questions?

Feel free to:
- Open a discussion on GitHub
- Contact the maintainers

Thank you for contributing! 🎉
