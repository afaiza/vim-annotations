# vim-annotations

Using VIM as a simple tool for data annotation.

## Prerequisites  

- You have VIM installed, https://www.vim.org/
- You have python installed
- You (kind of) know your way around VIM and python, e.g. how to source files from your ~/.vimrc

## Highlights 

Create VIM shortcuts that add annotations to a text files, for annotating
 - phrase classification - tasks like sentiment analysis
 - words classification - tasks like named entity recognition. 

### Phrase classification

The functions make_negative() and make_positive() in the file phrase_level_annotation.vim assume that you have a tab separated file (tsv) that has a header, and this header contains the columns "text" and "sentiment_orientation".

It creates the following shortcuts

- zn - makes the column sentiment_orientation negative for this line
- zp - makes the column sentiment_orientation positive for this line
- zq - clear annotation

| Original | you press zn | you press zq |
| -------- | ------------ | ------------ |
| ![image](https://github.com/user-attachments/assets/6f908aa7-de2c-4658-aea1-5a0a6dde0a9f) | ![image](https://github.com/user-attachments/assets/df5e827d-8a36-4cc3-99ad-c26169fcac30) | ![image](https://github.com/user-attachments/assets/27348530-604f-438c-b612-1493fb601dcb) |



### Word classification

The file word_level_annotation.vim contains shortcuts that surround a visual block with a tag.

It also contains a the shortcut ce that deletes an annotation and ,2 that merges two annotations in the same line, if they don't have anything but spaces between them.

It creates the following shortcuts

- cl - annoate the visual block as GEO
- cd - annoate the visual block as DATE
- cg - annoate the visual block as ORG
- cn - annoate the visual block as PERSON
- cr - annoate the visual block as CURRENCY
- ,1 - annoate the visual block as REPLACE_ME
- ce - clear the annotation

| Original | you press cn | you press ce |
| -------- | ------------ | ------------ |
| ![image](https://github.com/user-attachments/assets/5a756b6b-281a-44e4-8b46-b4147055324a) | ![image](https://github.com/user-attachments/assets/fe60d2d0-7ee5-4bac-844b-d8c55ff4e71b) | ![image](https://github.com/user-attachments/assets/51398e0b-e338-4ce2-a2e7-246937ad0d70) |





