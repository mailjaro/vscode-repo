# Makefile VSCODE-DOC project

# source markdown and configuration
MD = vscode.md
COMMON = config/common.yaml
BUILD = builds

# output files
EPUB_DARK = $(BUILD)/vscode-dark.epub
EPUB_LIGHT = $(BUILD)/vscode-light.epub
HTML1 = $(BUILD)/vscode-1.html
HTML2 = $(BUILD)/vscode-2.html
PDF = $(BUILD)/vscode.pdf

ASCIIDOC_CSS = styles/asciidoctor-default.css
ASCIIDOCTOR_THEME = styles/asciidoctor-default.yml

.PHONY: all epub html1 html2 pdf clean

all: epub html1 html2 pdf

# ensure build directory exists
$(BUILD):
	@mkdir -p $@

# --- EPUB ------------------------------------------------------------------
epub: $(BUILD) $(EPUB_DARK) $(EPUB_LIGHT)

$(EPUB_DARK): $(MD) $(COMMON) | $(BUILD)
	@pandoc $(MD) --metadata-file=$(COMMON) \
	       --css=styles/epub-dark.css -o $@
	@echo "✅ EPUB DARK successfully built."

$(EPUB_LIGHT): $(MD) $(COMMON) | $(BUILD)
	@pandoc $(MD) --metadata-file=$(COMMON) \
	       --css=styles/epub-light.css -o $@
	@echo "✅ EPUB LIGHT successfully built."

# --- intermediate AsciiDoc files -------------------------------------------

# converted directly from markdown once per build chain
vscode-1.adoc: $(MD) $(COMMON)
	@pandoc $(MD) --metadata-file=$(COMMON) --wrap=none \
	       -f markdown-smart -o $@

# remove emojis when generating HTML2/PDF
vscode-2.adoc: vscode-1.adoc
	@cp $< $@
	@sd '\p{Extended_Pictographic}\uFE0F? ' '' $@

# add unbreakable attributes before certain source blocks for PDF
vscode-3.adoc: vscode-2.adoc
	@cp $< $@
	@sd '\[source,output\]' '[%unbreakable]\n[source,output]' $@
	@sd '\[source,bash\]' '[%unbreakable]\n[source,bash]' $@

# --- HTML 1 ----------------------------------------------------------------
html1: $(HTML1)

$(HTML1): config/masterHTML-1.adoc vscode-1.adoc | $(BUILD)
	@asciidoctor -a stylesheet=../$(ASCIIDOC_CSS) \
	            -a data-uri config/masterHTML-1.adoc -o $@
	@echo "✅ HTML 1 successfully built."

# --- HTML 2 ----------------------------------------------------------------
html2: $(HTML2)

$(HTML2): config/masterHTML-2.adoc vscode-2.adoc | $(BUILD)
	@asciidoctor -a stylesheet=../$(ASCIIDOC_CSS) \
	            -a data-uri config/masterHTML-2.adoc -o $@
	@echo "✅ HTML 2 successfully built."
# --- PDF -------------------------------------------------------------------
pdf: $(PDF)

$(PDF): config/masterPDF.adoc vscode-3.adoc | $(BUILD)
	@asciidoctor-pdf config/masterPDF.adoc --theme=$(ASCIIDOCTOR_THEME) \
	                -o $@
	@echo "✅ PDF successfully built."

# --- cleanup ---------------------------------------------------------------
clean:
	@rm -rf $(BUILD) vscode-1.adoc vscode-2.adoc vscode-3.adoc
	@echo "✅ Cleaned up build artifacts."

