# 📘 Litt om VS Code

[Visual Code Studio](https://code.visualstudio.com/) (gjerne forkortet VS Code) er en gratis, lett og svært populær kildekode-editor utviklet av Microsoft. Den er designet for å hjelpe utviklere med å skrive, feilsøke og redigere kode for en rekke programmeringsspråk, og fungerer på Windows, macOS og Linux.

 VS Code er/har:

- Lett og rask: Starter raskt og bruker lite systemressurser.

- IntelliSense: Tilbyr intelligent kodefullføring basert på variabeltyper, funksjonsdefinisjoner og importerte moduler.

- Innebygd Git-støtte: Gjør det enkelt å håndtere versjonskontroll direkte i editoren.
  
- Extensions (utvidelser): Man kan tilpasse editoren med tusenvis av utvidelser for nesten alle programmeringsspråk (Python, Java, PHP, Go, C++, etc.), for filformater som HTML, CSS, TypeScript, JSON, Markdown, Asciidoc etc, samt for temaer og ulike verktøy.

- Integrert terminal: Man kan kjøre kommandolinjeoppgaver uten å forlate editoren.

- Debugging: Innebygd støtte for å feilsøke kode, sjekke variabler og se *call stacks*.

Men med all denne funksjonaliteten og fleksibiliteten, følger også kompleksitet i oppsett og innstillinger. JSON er valgt for håndtering av innstillinger, og i starten kan den totale mengden virke overveldende. Likeledes kreves en rekke extensions for å jobbe med ulike programmeringsspråk eller filformater. Disse må oppdateres, stadig nye tilbys, og over tid kan oversikt og kontroll avta.

Dette heftet forsøker å være til hjelp for dem som ønsker å få en viss oversikt over VS Code. Det fokuseres altså på

- ⚙️ JSON-instillinger
- 🧩 Utvidelser

VS Code ellers mange muligheter for å effektivisere arbeid. Det fins snippets, multiredigering, snarveier og mye annet. Det er imidlertid for omfattende å behandle dette her, men vi skal i det minste se litt på

- ⚡ bruk av kommando-paletten, og
- 🤖 task automation.

I tillegg er VS Code fint og bruke for Git versjonskontroll, både lokalt og *remote* mot  tjenester som f.eks. GitHub. Kjenner man de viktigste Git-kommandoene, vil bruk av Git på Vs Code føles enkelt. Det har også fordelen av at det å angre aksjoner gjøres kun ved å trykke en minus-knapp (framfor å måtte benytte kommandoopsjoner man vanskelig klarer å huske).

Vi vil gjennomgående basere oss på et Linux-system, slik at kataloger og eksempler i heftet gjelder Linux.

## 💻 Installasjon

Det er enkelt å installere VS Code på ulike distroer, og vi trenger ikke ta detaljene. Men man har gjerne to valg: installere gjennom Flatpak, Snap eller tilsvarende, eller å installere en RPM-versjon, f.eks. via `sudo dnf install code` på Fedora. For VS Code er det sistnevnte å foretrekke. Sandboksingen som omslutter Flatpak-/Snap-pakker, kan undertrykke settinger som kompilatorer trenger for å fungere (som config-filer, shell-stier og annet). Undertegnede brukte selv en frustrerende dag på å få et "*Hello World*"-program i Kotlin til å fungere, med all mulig nettsøk og AI-assistanse tilgjengelig, før det ble klart at sandboksing var problemet.

## 📄 JSON

JSON (JavaScript Object Notation) er et tekstbasert format for lagring og utveksling av strukturerte data, hovedsakelig brukt mellom en server og en web-applikasjon. Det er uavhengig av programmeringsspråk og enkelt for maskiner å tolke. Dataene struktureres primært i nøkkel/verdi-par og lister (arrays). Datatyper inkluderer strenger, tall, boolske verdier, null, arrays og andre objekter.

Her ser vi eksempel på syntaks:

```json
{
  "navn": "Ola Nordmann",
  "alder": 30,
  "erStudent": false,
  "kurs": ["Programmering", "Web-utvikling"]
}
```

## ⚙️ JSON-innstillinger

JSON-innstillingene i VS Code er inndelt i følgende hierarki:

1. Folder settings (multi root settings)
2. Workspace settings (for hvert prosjekt)
3. User settings (globalt for brukeren)
4. Default settings (innebygd i VS Code)

De først nevnte vil overstyre de senere. Altså, om Workspace sier noe om `fontSize": 14`, mens User sier `fontSize": 12`, blir fontstørrelse 14 gjeldende.

Den første, *multi root settings*, er aktuell bare når VS Code har flere toppmapper åpne samtidig. Dette er for mer spesiell bruk, og vi skal ikke se på det her. Det normale er å åpne VS Code på arbeidskatalogen til prosjektet, som gjerne må ha mange underkataloger. (Dette er likevel ikke *multi root*. *Multi root* startes ved å klikke **File/Add folder to Workspace ...** i VS Code-menyen og leder til en egen **.code-workspace**-fil.)

VS Code har i tillegg noen preferanser brukeren kan sette (ofte knyttet til layout som mørkt eller lyst tema, om paneler skal vises til høyre eller venstre etc) som ikke er en del av JSON-systemet og som lagres separat.

Workspace settings ligger i følgende fil på arbeidskatalogen:

```text
<prosjektmappe>/.vscode/settings.json
```

User settings ligger i følgende fil:

```text
~/.config/Code/User/settings.json
```

Det anbefales ikke å editere disse direkte, men heller bruke et GUI som VS Code.

### 📁 JSON-filer

Man kan åpne JSON-filene til User og Workspace via kommandopaletten (`Ctrl+P`) ved:

```text
Preferences: Open User Settings (JSON)
Preferences: Open Workspace Settings (JSON)
```

Disse er normalt små og oversiktlige. Disse inneholder bare verdier bruker har satt. Heller ikke extensions legger inn settinger her.

Man kan også få oversikt over default-verdier nøklene har via kommandopaletten ved

```text
Preferences: Open Default Settings (JSON)
```

Denne filen er imidlertid  kjempestor, så her må man søke etter bestemte nøkler.

For å eksemplifisere: Anta User settings inneholder

```json
"editor.fontFamily": "Fira Code, Consolas, 'Courier New' monospace"
```

Et søk etter **editor.fontFamily** i default settings viser at nøkkelen har denne default-verdien:

```json
"editor.fontFamily": "'Droid Sans Mono', monospace"
```

Slik kan man enkelt eksperimenter, resette til default verdi osv, uten å rote noe til eller miste oversikt, i det minste med nøkler man kjenner litt til.

Husk også at man kan kommentere i JSON-filene ved:

```text
// Midlertidig test
```

hvilket også vil være til hjelp.

### 📂 Settingsvinduet

For å åpne settingsvinduet kan man klikke `Ctrl + ,`. Det første man ser er en full, dynamisk dokumentasjon av JSON-settingene, brukervennlig og oversiktlig. Her bør man lese og gjøre seg kjent. I tillegg kan man lete etter bestemte ord eller konkrete nøkler i søkefeltet, som vi straks skal se på.

Øverst ser man også en knapp **Backup and Sync Settings**. Her kan man sett opp en synkronisering av VS Code-innstillingene, slik at man kan ha samme arbeidsmiljø på flere PC-er. Da deles

- User settings (**settings.json**)
- Keybindings
- Snippets
- Themes, ikoner og andre preferences
- Extensions (installerte utvidelser og deres innstillinger)

Dette deles ikke:

- Workspace settings (**.vscode/settings.json**) synkes ikke.
- Folder / multi-root settings

Workspace-settings er spesifikke for hvert prosjekt, og normalt deles disse (**.vscode/settings.json**) via av et vanlig Git/GitHub-håndtert prosjekt.

En særlig nyttig søk i settingsvinduet er ved følgende filter:

```text
@modified
```

Denne viser, både for User og Workspace, hvilke endringer bruker har gjort. I dette vinduet kan man så lese om nøkler, eksperimentere med innstillinger og i det hele tatt holde oversikt over det som gjerne angår en mest.

La oss som eksempel søker etter **editor.fontFamily** i søkefeltet. Da får man fram dokumentasjonen for denne nøkkelen. Man ser verdien nøkkelen har enten i User eller Workspace (velges rett under søkefeltet). I mitt tilfelle vises

```text
Fira Code, Consolas, 'Courier New', monospace
```

for User og

```text
'Droid Sans Mono', monospace
```

for workspace.

Her må vi stoppe opp og avklare noe som ofte forvirrer. Alene forteller ikke verdifeltet i Settingsvinduet hvilken verdi nøkkelen faktisk har. Default-verdi vises nemlig om tilhørende nøkkelen ikke er satt. I eksempelet settes det følgende eksplisitt i User-json

```json
"editor.fontFamily": "Fira Code, Consolas, 'Courier New', monospace"
```

mens Workspace-json ikke setter nøkkelen. Det betyr at font-settingen bruker har satt globalt faktisk gjelder prosjektet man jobber med. Men ut fra settingsvinduet (dokumentasjonsvinduet), siden Workspace overstyrer User, kan det se ut som at

```json
"editor.fontFamily": "'Droid Sans Mono', monospace"
```

er aktiv, hvilket den ikke er. Det er altså JSON-filene som viser verdiene som er satt, ikke alltid visningsfeltet i Settingsvinduet.

Likevel, settingsvinduet er nyttig. Man kan sette verdier, og tilhørende JSON-fil oppdateres automatisk. Motsatt oppdatering skjer også. Videre har vi sett viktigheten av søkefilter  `@modified`, og vi har i tillegg flere slike:

```text
@modified:    — hva som er endret
@id:          — hopp direkte til en nøkkel
@ext:         — extensions
@lang:        — språkrelatert filtering  (MD, ADOC, ...)
@tag:         — filtrer på metadata-tags
@feature:     — VSCode-område (editor, terminal, git, filutforsker, ... )
@policy:      — settings som kan styres av organisasjon/policy
```

VS Code vil autofullføre disse (foreslå mulige fortsettelser der det er mulig), og man kan også kombinere dem:

```text
@modified @id:editor.fontFamily
```

```text
@modified @ext:markdown
```

```text
@feature:editor @modified
```

Når man finner fram til aktuell nøkkel, kan man også klikk på tannhjulet ⚙️ ved siden av og resette verdi til default eller kopiere settingen ut (f.eks. i JSON-format).

### ⚙️ Struktur i JSON Default settings

Selve filen inneholder ca. 11 000 linjer og kan synes vanskelig å få oversikt i.  Men alt er hierarkisk organisert i “namespaces” gruppert med punktnotasjon. Her ser vi vi de øverste nivåene:

```text
settings
│
├── editor
│   ├── font*
│   ├── cursor*
│   ├── format*
│   ├── suggest*
│   ├── minimap*
│   ├── wordWrap
│   ├── tabSize
│   └── render*
│
├── files
│   ├── autoSave
│   ├── encoding
│   ├── exclude
│   ├── associations
│   └── trim*
│
├── workbench
│   ├── colorTheme
│   ├── iconTheme
│   ├── startupEditor
│   ├── activityBar*
│   ├── editor*
│   └── sideBar*
│
├── window
│   ├── zoomLevel
│   ├── title*
│   └── openFilesInNewWindow
│
├── terminal
│   └── integrated
│       ├── font*
│       ├── shell*
│       ├── profiles*
│       ├── scrollback
│       └── cursor*
│
├── explorer
│   ├── confirmDelete
│   ├── sortOrder
│   └── compactFolders
│
├── search
│   ├── exclude
│   ├── useIgnoreFiles
│   └── followSymlinks
│
├── git
│   ├── enabled
│   ├── autofetch
│   ├── confirmSync
│   └── decorate*
│
├── debug
│   ├── openDebug
│   ├── inlineValues
│   └── toolBarLocation
│
├── extensions
│   └── (extension-specific settings)
│
└── [language-id]
    ├── editor.*
    ├── files.*
    └── format*
```

der en JSON-notasjon som f.eks.

```json
"editor.fontSize": 14
```

representeres ved

```text
editor
 └── fontSize
```

Systemet er dypere enn vist på flere steder.

### 🔑 Viktige nøkler

Det er umulig, og ikke nødvendig, å ha oversikt over større deler av nøkkelsettet til VS Code. Her kommer imidlertid et gruppert utvalg som kan være aktuelt i starten.

#### 1️⃣ Editor / redigering

```text
NØKKEL                  HVA DEN GJØR                  TYPISK VERDI
editor.fontFamily       Skrifttype i editor           "Fira Code", monospace
editor.fontSize         Størrelse på teksten          14, 16 …
editor.lineHeight       Linjeavstand                  20, 1.5 …
editor.wordWrap         Om linjer skal brytes         "on", "off", "wordWrapColumn"
editor.tabSize          Hvor mange mellomrom per tab  2 eller 4
editor.insertSpaces     Tab er spaces eller ekte tab  true / false
editor.formatOnSave     Autoformattering ved lagring  true / false
editor.minimap.enabled  Viser eller skjuler minimap   true / false
```

#### 2️⃣ Språkspesifikke innstillinger

```text
NØKKEL                    FUNKSJON          TYPISK VERDI
editor.quickSuggestions   Skrive forslag    true/false
editor.formatOnSave       Autoformatering   true
editor.tabSize            Tab-størrelse     2/4
```

#### 3️⃣ Filer

```text
NØKKEL                        FUNKSJON                TYPISK VERDI
files.autoSave                Autolagring             "afterDelay", "onFocusChange"
files.exclude                 Skjuler filer           {"**/.git": true}
files.trimTrailingWhitespace  rm whitespace on save   true
files.insertFinalNewline      Newline på slutten      true
files.encoding                Filkoding               "utf8"
```

#### 4️⃣ Editor / display / UI

```text
NØKKEL                   FUNKSJON
workbench.colorTheme     Tema (dark/light)
workbench.iconTheme      Ikonpakke for filer
editor.renderWhitespace  Viser spaces/tabs
editor.cursorBlinking    Blinking cursor
editor.lineNumbers       Linjenummer visning
```

#### 5️⃣ Linting / formatering / Markdown / AsciiDoc

```text
NØKKEL                        FUNKSJON
markdownlint.config           Konfig for markdownlint
markdown.preview.breaks       Hard line breaks i preview
markdown.preview.fontFamily   Font i preview
asciidoc.preview.fontFamily   Font i preview
asciidoc.preview.breaks       Hard line breaks
asciidoc.extension.path       Tilpass path til Asciidoctor binær
```

#### 6️⃣ Git

```text
NØKKEL                  FUNKSJON
git.enableSmartCommit   Commit uten å skrive melding
git.autofetch           Henter automatisk
git.confirmSync         Bekreft før sync
```

#### 7️⃣ Terminal / konsoll

```text
NØKKEL                                FUNKSJON
terminal.integrated.fontFamily        Terminal font
terminal.integrated.fontSize          Terminal font size
terminal.integrated.scrollback        Hvor mange linjer som huskes
terminal.integrated.cursorBlinking    Cursor blinking
```

## 🧩 Extensions

Også når det gjelder extensions kan eksperimentering over tid føre til redusert oversikt. Så man kan trenge å få oversikt over installerte extensions, hvilke som er aktive eller ikke, og hvilke man evt. kan avinstallere.

Man kan åpne extensions-panelet grafisk eller ved

```text
Ctrl + Shift + X
```

Her vil en serie extensions listes, både de man allerede har og mange andre som tilbys. Man kan filtrere etter følgende valg ved å klikke på filtreringsikonet til høyre i søkefeltet.

```text
- Installed   → alt du har
- Updates     → hvilke som kan oppdateres
- Built in    → innebygde extensions
- Enabled     → faktisk aktive
- Disabled    → installert men ikke i bruk
```

Man kan også søke på bestemt ting, f.eks. knyttet til C++, Python, Markdown, Asciidoc etc, ved:

```text
@installed markdown
```

```text
@installed asciidoc
```

I tillegg kan man fra **Command Palett** (Ctrl+P) taste inn

```text
Extensions: Show Running Extensions
```

Uansett kan man se hvilke utvidelser som er aktive (enabled) eller ikke-aktive (disabled), og man kan velge/endre dette i vinduene som dukker opp når man klikker på utvidelsene.

Det er ikke uvanlig å ha endt opp i en situasjon der konkurrerende utvidelser kjører (der flere tilbyr samme tjenester), så det kan være greit å rydde litt innimellom, prøve hvilke man er mest fornøyd med, og deaktivisere resten (evt avinstallere dem når man har bestemt seg).

Utvidelser kan også installeres fra kommandlinjen. En fordel er at utvidelsesspesifiseringene der er entydig gitt, mens navnet kan være flertydig. Ifm. reinstallasjoner er kommandoversjonene godt å ha notert. Her vises eksempler som gjør man kan komme igang med Kotlin, Python of C/C++ for programmering, og for Markdown- og Asciidoc-skriving/-visning:

```bash

# Kotlin
code --install-extension fwcd.kotlin
code --install-extension matklad.kotlin-test-runner
code --install-extension formulahendry.code-runner

# Python
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension njpwerner.autodocstring

# C / C++
code --install-extension ms-vscode.cpptools
code --install-extension vadimcn.vscode-lldb
code --install-extension ms-vscode.cmake-tools
code --install-extension austin.code-gnu-global

# Markdown
code --install-extension yzhang.markdown-all-in-one
code --install-extension shd101wyy.markdown-preview-enhanced

# AsciiDoc
code --install-extension asciidoctor.asciidoc
```

## 🤖 Task automation

For de som jobber med spesielle ting som Python, C++ etc, fins det en mengde snippets og automation-tips der ute. Her skal vi vise en mer generell oppgave, nemlig hvordan man automatiserer kjøring av et shell-skript (kalt **runner.sh**) på prosjektkatalogen.

Dette er relativt enkelt å sette opp. I VS Code gjør man:

1. Åpne prosjektmappen
2. Trykk `Ctrl+P`
3. Skriv **Tasks: Configure Task**
4. Velg **Create tasks.json file from template**
5. Velg **Others**

Dette genererer filen

```text
.vscode/tasks.json
```

som nå åpnes i VS Code. Rediger innholdet til:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Passende beskrivelse",
      "type": "shell",
      "command": "./runner.sh",
      "group": "build",
      "problemMatcher": []
    }
  ]
}
```

Tasken kan nå kjøres ved `Shift+Ctrl+B` og deretter klikke på tasken med beskrivelsen du valgte.

Linjene

```json
"group": "build",
"problemMatcher": []
```
er nyttige å legge til. Den første gjør at VS Code hopper rett til `Run Task` etter `Shift+Ctrl+B`, mens den andre gjør at eventuell output ikke tolkes som kompilator-feil.

Skal man siden automatisere flere tasks, legges disse inn i samme fil.

## ⚡ Command Pallette

Vi har benyttet kommandopaletten (som er svært nyttig) flere ganger. Her skal vi supplere med ting hva man kan gjøre.

For det første er oppgavene på formen:

```text
[System / Modul]: [Handling]
```

som f.eks.

```text
Preferences: Open User Settings (JSON)
```

Man trenger ikke å skrive hele kommandoen. I praksis en gjør VS Code en fuzzy search blant alle kommandoer.

En tre-representasjon av palettens muligheter ser slik ut:

```text
Command Palette
│
├── File
│   ├── New File
│   ├── Open File
│   ├── Save
│   ├── Save All
│   └── Reopen Closed Editor
│
├── Edit
│   ├── Undo / Redo
│   ├── Format Document
│   ├── Rename Symbol
│   ├── Refactor
│   └── Emmet Expand
│
├── View
│   ├── Toggle Sidebar
│   ├── Toggle Panel
│   ├── Appearance
│   │   ├── Change Theme
│   │   ├── Change Icon Theme
│   │   └── Toggle Full Screen
│   └── Open View (Explorer, Search, SCM, Run)
│
├── Go / Navigation
│   ├── Go to File
│   ├── Go to Symbol
│   ├── Go to Definition
│   ├── Go to Line
│   └── Go Back / Forward
│
├── Search
│   ├── Find in File
│   ├── Replace
│   ├── Search in Workspace
│   └── Toggle Regex / Case / Whole Word
│
├── Terminal
│   ├── Create New Terminal
│   ├── Split Terminal
│   ├── Select Default Profile
│   └── Run Active File
│
├── Tasks
│   ├── Run Task
│   ├── Configure Task
│   ├── Restart Running Task
│   └── Terminate Task
│
├── Debug
│   ├── Start Debugging
│   ├── Add Configuration
│   ├── Select Debug Configuration
│   └── Toggle Breakpoint
│
├── Git / Source Control
│   ├── Commit
│   ├── Push
│   ├── Pull
│   ├── Checkout Branch
│   └── Stage Changes
│
├── Extensions
│   ├── Install Extensions
│   ├── Show Installed Extensions
│   ├── Disable Extension
│   └── Reload Window
│
├── Preferences
│   ├── Open Settings (UI)
│   ├── Open Settings (JSON)
│   ├── Keyboard Shortcuts
│   ├── Profiles
│   └── Settings Sync
│
└── Developer
    ├── Reload Window
    ├── Toggle Developer Tools
    ├── Inspect Context Keys
    └── Show Running Extensions
```

Noen hendige snarveier i paletten er:

```text
>     : Kommandomodus (Ctrl+Shift+P)      F1, Ctrl+Shift+P
#     : Søk i workspace-symboler          Ctrl+T
@     : Symboler i gjeldende fil          Ctrl+Shift+O
@:    : Symboler gruppert etter type
:     : Gå til linjenummer                Ctrl+G
?     : Hjelpemodus
<fil> : Åpne fil
<kat> : Åpne katalog
```

## 🧠 Andre ting å fordype seg i

VS Code har flere muligheter for effektivisering av arbeid. Hva man vil satse på avhenger av type prosjekt, smak og annet. Her vil vi bare nevne ting man bør søke opp dersom begynner å jobbe mer intensivt.

- Snippets for å sette inn kodeblokker/faste tesktstrukturer
- *Multi cursor editing* for kjapp editering flere steder i teksten samtidig
- Snarveier / *keybindings*
- Profiles for separate arbeidsmiljøer inni VS Code

og sikkert mye annet.

## 📚 Andre bøker og hefter i serien

📘 Linux: Det neste steget

📘 [Litt om Git](https://mailjaro.github.io/git-repo/)

[📘 Litt om CSS](https://mailjaro.github.io/css-repo/)

📘 [Litt om GPG](https://mailjaro.github.io/gpg-repo/)