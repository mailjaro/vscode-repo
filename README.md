# 📘 Litt om VS Code

> Et kort, lite og praktisk hefte om Visual Studio Code på Linux.  
> Skrevet av Jan R Sandbakken.

---

## ❗ Viktig info

✅ Husk: Start enhver editering med

- `git fetch origin`
- `git pull`

✅ Husk: Avslutt enhver editering med

- Lagre alle ulagrede filer
- `./runner.sh` (anbefalt)
- `git add -A`
- `git commit -m "Beskrivelse"`
- `git push`

(Eller gjør det ekvivalente fra **VS Code**.)

---

## 📌 Om prosjektet

Dette prosjektet inneholder kildematerialet (**vscode.md**) til heftet **"Litt om VS Code"**.

Heftet er skrevet for Linux-brukere og fokuserer på å få kontroll på:

- ⚙️ JSON-innstillinger
- 🧩 Utvidelser

## 🗂️ Struktur

Her ser vi den fulle strukturen når alt er konvertert mog produsert (hvilket kan oppnås ved å kjøre skriptet `runner.sh`):

```text
.
├── builds
│   ├── vscode-1.html
│   ├── vscode-2.html
│   ├── vscode-dark.epub
│   ├── vscode-light.epub
│   └── vscode.pdf
├── config
│   ├── common.yaml
│   ├── masterHTML-1.adoc
│   ├── masterHTML-2.adoc
│   └── masterPDF.adoc
├── images
│   └── cover.png
├── Makefile
├── README.md
├── runner.sh
├── styles
│   ├── asciidoctor-default.css
│   ├── asciidoctor-default.yml
│   ├── epub-dark.css
│   └── epub-light.css
├── vscode-1.adoc
├── vscode-2.adoc
├── vscode-3.adoc
└── vscode.md     ← HOVEDFIL (KILDEFIL)
```

## 📌 Eksport til EPUB

EPUB kan med hell produseres direkte fra MD med `pandoc`. En CSS for mørk og lys stil er laget, samt en **common.yaml** for metadata.

Her er `pandoc`-kommandoene for hver av stilene:

```bash
pandoc vscode.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-dark.css -o \
   builds/vscode-dark.epub
```

```bash
pandoc vscode.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-light.css -o \
   builds/vscode-light.epub
```

Her er metadataene i **common.yaml**:

```text
title: "Litt om VS Code"
author: "Jan Roger Sandbakken"
version: "1.0"
date: "2026-02-19"
language: "nb"
rights: © 2026 Jan Roger Sandbakken
```

## 📌 Konvertering til ADOC

Følgende kommando konverterer **vscode.md** til **vscode-1.adoc** (første av tre ADOC-versjoner). Denne inneholder bl.a. MD-ikoner:

```bash
pandoc vscode.md --metadata-file=./config/common.yaml \
                 --wrap=none -f markdown-smart \
                 -o vscode-1.adoc
```

## 📌 Uredigert eksport til HTML

For produksjon av formater ved `asciidoctor` er det laget masterfiler med *preambles* og nødvendig *includes*. Her er **masterHTML-1.adoc**:

```text
= Litt om VS Code
Jan R Sandbakken <mailjaro@gmail.com>
v1.0 2026-02-19
:description: Dette heftet forsøker å hjelpe til med å få oversikt over VS Code, nærmere bestemt om JSON.settings og extensions
:doctype: book
:icons: font
:toc: left
:toc-title: Innholdsfortegnelse
:toclevels: 4
:sectanchors:
:source-highlighter: rouge
:rouge-style: github
image::../images/cover.png[role=cover,align=center]

include::../vscode-1.adoc[]
```
I tillegg er default CSS for `asciidoctor` hentet inn og inkluderes i følgende produksjonskommando:

```bash
asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri -a linkcss=false \
            config/masterHTML-1.adoc \
            -o builds/vscode-1.html
```

Opsjonene

```bash
-a linkcss=false
-a data-uri
```
sørger for at en produsert CCS og bilde (forsidebilde) inkluderes direkte i HTML-filen (så den enkelt kan flyttes rundt).

## 📌 Redigering av ADOC

Man starter med å kopiere `vscode-1.adoc` til `vscode-2.adoc` (alle endringer gjøres så på sistnevnte):

```bash
cp vscode-1.adoc vscode-2.adoc
```

Deretter sørger man for at `source`-objekter ikke blir linjedelt (viktig for PDF):

```bash
sd '\[source,text\]' '[%unbreakable]\n[source,text]' vscode-2.adoc
sd '\[source,json\]' '[%unbreakable]\n[source,json]' vscode-2.adoc
```

Så fjernes ikoner (håndteres ikke av PDF). For dette konkrete heftet er det nødvendig og tilstrekkelig å gjøre:

```bash
sd '📘 ' '' vscode-2.adoc
sd '⚙️ ' '' vscode-2.adoc
sd '🧩 ' '' vscode-2.adoc
sd '📄 ' '' vscode-2.adoc
sd '📁 ' '' vscode-2.adoc
sd '📂 ' '' vscode-2.adoc
sd '🔑 ' '' vscode-2.adoc
sd '1️⃣ ' '1. ' vscode-2.adoc
sd '2️⃣ ' '2. ' vscode-2.adoc
sd '3️⃣ ' '3. ' vscode-2.adoc
sd '4️⃣ ' '4. ' vscode-2.adoc
sd '5️⃣ ' '5. ' vscode-2.adoc
sd '6️⃣ ' '6. ' vscode-2.adoc
sd '7️⃣ ' '7. ' vscode-2.adoc
```

## 📌 Redigert eksport til HTML

Følgende kommando produserer HTML fra den nyredigerte `vscode-2.adoc` (inkludert i HTML-masterfil 2):

```bash
asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri -a linkcss=false \ 
            config/masterHTML-2.adoc -o builds/vscode-2.html
```

## 📌 Redigert eksport til PDF

Tanken er nå at man har behov for å redigerer ytterligere for PDF, kanskje legge inn nødvendig legge sideskift (`<<<`) enkelte steder o.l. Det forutsettes her at man derfor først kopiere  `vscode-2.adoc` til `vscode-3.adoc` og redigerer denne videre.

Masterfilen for PDF ser nemlig slik ut:

```text
= Litt om VS Code
Jan R Sandbakken <mailjaro@gmail.com>
v1.0 2026-02-12
:description: Dette heftet forsøker å hjelpe til med å få oversikt over VS Code, nærmere bestemt om JSON.settings og extensions
:doctype: book
:front-cover-image: image:../images/cover.png[]
:title-page:
:icons: font
:toc: left
:toc-title: Innholdsfortegnelse
:toclevels: 4
:sectanchors:
:source-highlighter: rouge
:rouge-style: base16.dark

include::../vscode-3.adoc[]
```

Følgende kommando produserer da PDF-versjon av boken:

```bash
asciidoctor-pdf config/masterPDF.adoc \
                --theme=styles/asciidoctor-default.yml \
                -o builds/vscode.pdf
```

## 🐚 Kommandoer samlet i et shell

Her er alt av kommandoer samlet i et fish-shell `runner.sh`:

```bash
#!/usr/bin/fish
pushd ~/Documents/doc/vscode-doc

pandoc vscode.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-dark.css -o \
   builds/vscode-dark.epub

pandoc vscode.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-light.css -o \
   builds/vscode-light.epub

pandoc vscode.md --metadata-file=./config/common.yaml \
                 --wrap=none -f markdown-smart -o vscode-1.adoc

asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri \
            config/masterHTML-1.adoc -o builds/vscode-1.html

cp vscode-1.adoc vscode-2.adoc
sd '\[source,text\]' '[%unbreakable]\n[source,text]' vscode-2.adoc
sd '\[source,json\]' '[%unbreakable]\n[source,json]' vscode-2.adoc
sd '📘 ' '' vscode-2.adoc
sd '⚙️ ' '' vscode-2.adoc
sd '🧩 ' '' vscode-2.adoc
sd '🤖 ' '' vscode-2.adoc
sd '⚡ ' '' vscode-2.adoc
sd '📄 ' '' vscode-2.adoc
sd '📁 ' '' vscode-2.adoc
sd '📂 ' '' vscode-2.adoc
sd '🔑 ' '' vscode-2.adoc
sd '🧠 ' '' vscode-2.adoc
sd '📚 ' '' vscode-2.adoc
sd '1️⃣ ' '1. ' vscode-2.adoc
sd '2️⃣ ' '2. ' vscode-2.adoc
sd '3️⃣ ' '3. ' vscode-2.adoc
sd '4️⃣ ' '4. ' vscode-2.adoc
sd '5️⃣ ' '5. ' vscode-2.adoc
sd '6️⃣ ' '6. ' vscode-2.adoc
sd '7️⃣ ' '7. ' vscode-2.adoc

asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri -a \
            config/masterHTML-2.adoc -o builds/vscode-2.html

cp vscode-2.adoc vscode-3.adoc
asciidoctor-pdf config/masterPDF.adoc --theme=styles/asciidoctor-default.yml \
                -o builds/vscode.pdf

popd
```

## 📌 Makefile

Det er laget en midlertidig Makefile som hjelper både med produksjon og lesing, foreløpig bare

```bash
make epub
```

som produserer (den mørke) EPUB-filen, mens kommandoen

```bash
make open-epub
```

åpner denne for lesing.

Dette vil bli utvidet senere.

## 📚 Andre bøker og hefter i serien

📘 Linux: Det neste steget

📘 Litt om Git

📘 Litt om GPG
