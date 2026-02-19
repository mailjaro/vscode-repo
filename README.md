# 📘 Litt om VS Code

> Et kort, lite og praktisk hefte om Visual Studio Code på Linux.  
> Skrevet av Jan R Sandbakken.

---

## 📌 Om prosjektet

Dette prosjektet inneholder kildematerialet (**vscode.md**) til heftet **"Litt om VS Code"**.

Heftet er skrevet for Linux-brukere og fokuserer på å få kontroll:

- ⚙️ JSON-innstillinger
- 🧩 Utvidelser

## 📦 Bygging av EPUB

For å konvertere fra MD til EPUB, benyttes kommandoen

```bash
pandoc vscode.md \
  --metadata-file=common.yaml -o vscode.epub
```

**common.yaml** inneholder metadata, samt en linje

```css
css: light.css
```

der man kan velge mørkt eller lyst tema ved hhv. **dark.css** eller **light.css**.

Det er laget en Makefile som hjelper både med produksjon og lesing. Kommandoen

```bash
make epub
```

produserer EPUB-filen, mens kommandoen

```bash
make open-epub
```

åpner denne for lesing.

📚 Andre bøker og hefter i serien

📘 Linux: Det neste steget

📘 Litt om Git

📘 Litt om GPG
