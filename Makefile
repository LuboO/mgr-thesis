PDFFILES=mgr-thesis.pdf
BIBLIOGRAPHY=bibliography.bib

PDFLATEX=pdflatex --shell-escape
AUXFILES=*.aux *.log *.out *.toc *.lot *.lof *.bcf *.blg *.run.xml \
		*.bbl *.idx *.ind *.ilg *.markdown.* *.synctex.gz
AUXDIRS=_markdown-*/ _markdown_*/ _minted-*/
OUTPUT=$(PDFFILES) $(PDFFILES:.pdf=.tex)

.PHONY: all

all: $(OUTPUT)

# This target typesets a pdfLaTeX example.
%.pdf: %.tex $(BIBLIOGRAPHY)
	$(PDFLATEX) $< # The initial typesetting.
	biber $(basename $<).bcf
	$(PDFLATEX) $< # Update the index after the bibliography insertion.
	xindy -I latex -C utf8 -L english $(basename $<).idx
	$(PDFLATEX) $< # The final typesetting, now also with index.
	$(PDFLATEX) $<

# This target removes any auxiliary files.
clean:
	rm -f $(AUXFILES)
	rm -rf $(AUXDIRS)

