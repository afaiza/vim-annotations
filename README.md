# vim-annotations

Using VIM as a simple tool for data annotation.

## Prerequisites  

- You have VIM installed, https://www.vim.org/
- You have python installed
- You (kind of) know your way around VIM and python, e.g. how to source files from your ~/.vimrc

## Highlights 

Create VIM shortcuts that add annotations to a text files, for annotating
 - phrase classification - tasks like sentiment analysis
 - words classificatio - tasks like and named entity recognition. 

### Phrase classification

The functions make_negative() and make_positive() in the file phrase_classification.vim assume that you have a tab separated file (tsv) that has a header, and this header contains the columns "text" and "sentiment_orientation".

It creates the following shortcuts

- zn - makes the column sentiment_orientation negative for this line
- zp - makes the column sentiment_orientation positive for this line
- zq - clear annotation

### Word classification

The file word_classification.vim contains shortcuts that surround a visual block with a tag.

It also contains a the shortcut ce that deletes an annotation and ,2 that merges two annotations in the same line, if they don't have space between them

