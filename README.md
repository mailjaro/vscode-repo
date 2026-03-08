# 📘 Litt om VS Code

A comprehensive litte document on [Visual Studio Code](https://code.visualstudio.com/), a free and popular source code editor developed by Microsoft. This document covers the essential topics for fairly new users to understand and control basic VS Code on Linux systems.

## 📚 Contents

This handbook focuses mostly on:

- **⚙️ JSON Settings** — Understanding and customizing VS Code configuration
- **🧩 Extensions** — Discovering and managing extensions for languages, file formats, themes, and tools
  
Also som basic use of

- **⚡ Command Palette** — Efficient command execution and workflow shortcuts
- **🤖 Task Automation** — Automating development tasks within VS Code


## 📖 Building the Document

The source document is converted into multiple output formats:

```bash
make all          # Build all formats
make epub1        # Pandoc EPUB (dark/light)
make epub2        # Asciidoctor EPUB (dark/light)
make html1        # HTML with emojis
make html2        # HTML without emojis
make pdf          # PDF document
make clean        # Remove build artifacts
```

Or use the build script:

```bash
./runner.sh       # Build all formats at once
```

## 🏗️ Build Outputs

- **EPUB** — Two themes (dark/light) in both pandoc and asciidoctor versions
- **HTML** — Two versions (with and without emojis)
- **PDF** — Styled PDF document with custom theme

All outputs are generated in the `builds/` directory.
