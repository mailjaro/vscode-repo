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
sd '📄 ' '' vscode-2.adoc
sd '📁 ' '' vscode-2.adoc
sd '📂 ' '' vscode-2.adoc
sd '🔑 ' '' vscode-2.adoc
sd '🤖 ' '' vscode-2.adoc
sd '⚡ ' '' vscode-2.adoc
sd '🧠 ' '' vscode-2.adoc
sd '1️⃣ ' '1. ' vscode-2.adoc
sd '2️⃣ ' '2. ' vscode-2.adoc
sd '3️⃣ ' '3. ' vscode-2.adoc
sd '4️⃣ ' '4. ' vscode-2.adoc
sd '5️⃣ ' '5. ' vscode-2.adoc
sd '6️⃣ ' '6. ' vscode-2.adoc
sd '7️⃣ ' '7. ' vscode-2.adoc

asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri \
            config/masterHTML-2.adoc -o builds/vscode-2.html

cp vscode-2.adoc vscode-3.adoc

asciidoctor-pdf config/masterPDF.adoc --theme=styles/asciidoctor-default.yml \
                -o builds/vscode.pdf

popd