epub: vscode.md config/common.yaml
	$(info Building EPUB:)
	@pandoc vscode.md --metadata-file=config/common.yaml \
	-o builds/vscode.epub

open-epub:
	@xdg-open "builds/vscode.epub"

preview: open-epub

spellcheck:
	@hunspell -d nb_NO -p .hunspell_ignore -l vscode.md | sort | uniq

add-word:
ifndef word
	$(error Usage: make add-word word=someword)
endif
	@echo "$(word)" >> .hunspell_ignore
	@sort -u .hunspell_ignore -o .hunspell_ignore

