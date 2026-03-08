# Makefile — VSCODE-DOC project

# -------------------------------------------------------------------
# configuration
# -------------------------------------------------------------------

MD       = vscode.md
COMMON   = config/common.yaml
BUILD    = builds

ASCIIDOC_CSS      = styles/asciidoctor-default.css
ASCIIDOCTOR_THEME = styles/asciidoctor-default.yml

MKDIR_P = mkdir -p
RM      = @rm -rf

# -------------------------------------------------------------------
# outputs
# -------------------------------------------------------------------

EPUB_PAN_DARK  = $(BUILD)/vscode-pan-dark.epub
EPUB_PAN_LIGHT = $(BUILD)/vscode-pan-light.epub

EPUB_ASC_DARK  = $(BUILD)/vscode-asc-dark.epub
EPUB_ASC_LIGHT = $(BUILD)/vscode-asc-light.epub

HTML1 = $(BUILD)/vscode-1.html
HTML2 = $(BUILD)/vscode-2.html
PDF   = $(BUILD)/vscode.pdf

# intermediate files
ADOC1 = vscode-1.adoc
ADOC2 = vscode-2.adoc
ADOC3 = vscode-3.adoc

# -------------------------------------------------------------------
# targets
# -------------------------------------------------------------------

.PHONY: all epub1 epub2 html1 html2 pdf clean

all: epub1 epub2 html1 html2 pdf

# ensure build directory exists
$(BUILD):
	@$(MKDIR_P) $@

# -------------------------------------------------------------------
# intermediate AsciiDoc
# -------------------------------------------------------------------

$(ADOC1): $(MD) $(COMMON)
	@pandoc $(MD) --metadata-file=$(COMMON) \
	       --wrap=none -f markdown-smart \
	       -o $@

# -------------------------------------------------------------------
# PANDOC EPUB
# -------------------------------------------------------------------

epub1: $(EPUB_PAN_DARK) $(EPUB_PAN_LIGHT)

$(EPUB_PAN_DARK): $(MD) $(COMMON) | $(BUILD)
	@pandoc $< --metadata-file=$(COMMON) \
	       --css=styles/epub-dark.css \
		   --metadata cover-image=images/cover.png \
	       -o $@
	@echo "✅ PANDOC EPUB DARK built."

$(EPUB_PAN_LIGHT): $(MD) $(COMMON) | $(BUILD)
	@pandoc $< --metadata-file=$(COMMON) \
	       --css=styles/epub-light.css \
		   --metadata cover-image=images/cover.png \
	       -o $@
	@echo "✅ PANDOC EPUB LIGHT built."

# -------------------------------------------------------------------
# OPPRYDDING OG FJERNING AV EMOJIS
# -------------------------------------------------------------------

$(ADOC2): $(ADOC1)
	@cp $< $@
	@sd '❗' 'NOTE:' $@
	@sd '‼️' 'CAUTION:' $@
	@sd '\p{Extended_Pictographic}\uFE0F? ' '' $@
	@sd ' [1-7]️⃣' '' $@

$(ADOC3): $(ADOC2)
	@cp $< $@
	@sd '\[source,output\]' '[%unbreakable]\n[source,output]' $@
	@sd '\[source,bash\]' '[%unbreakable]\n[source,bash]' $@
	@sd '\[source,json\]' '[%unbreakable]\n[source,json]' $@

# -------------------------------------------------------------------
# ASCIIDOCTOR EPUB
# -------------------------------------------------------------------

epub2: $(EPUB_ASC_LIGHT) $(EPUB_ASC_DARK)

$(EPUB_ASC_LIGHT): config/masterEPUB-light.adoc $(ADOC2) | $(BUILD)
	@asciidoctor-epub3 $< -o $@
	@echo "✅ ASCIIDOCTOR EPUB LIGHT built."

$(EPUB_ASC_DARK): config/masterEPUB-dark.adoc $(ADOC2) | $(BUILD)
	@asciidoctor-epub3 $< -o $@
	@echo "✅ ASCIIDOCTOR EPUB DARK built."

# -------------------------------------------------------------------
# HTML
# -------------------------------------------------------------------

html1: $(HTML1)

$(HTML1): config/masterHTML-1.adoc $(ADOC1) | $(BUILD)
	@asciidoctor \
		-a stylesheet=../$(ASCIIDOC_CSS) \
		-a data-uri \
		$< -o $@
	@echo "✅ HTML 1 built."

html2: $(HTML2)

$(HTML2): config/masterHTML-2.adoc $(ADOC2) | $(BUILD)
	@asciidoctor \
		-a stylesheet=../$(ASCIIDOC_CSS) \
		-a data-uri \
		$< -o $@
	@echo "✅ HTML 2 built."

# -------------------------------------------------------------------
# PDF
# -------------------------------------------------------------------

pdf: $(PDF)

$(PDF): config/masterPDF.adoc $(ADOC3) | $(BUILD)
	@asciidoctor-pdf $< \
		--theme=$(ASCIIDOCTOR_THEME) \
		-o $@
	@echo "✅ PDF built."

# -------------------------------------------------------------------
# cleanup
# -------------------------------------------------------------------

clean:
	$(RM) $(BUILD) $(ADOC1) $(ADOC2) $(ADOC3)
	@echo "✅ Cleaned build artifacts."