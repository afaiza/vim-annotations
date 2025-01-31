
map  zn :py3 make_negative()<CR>
map  zp :py3 make_positive()<CR>
map  zq :py3 clear_sentiment()<CR>

py3 << EOF
def column_of(t):
    header_vec = vim.current.buffer[0].strip().split("\t")
    index_mapping = { header: index for index, header in enumerate(header_vec) }

    return index_mapping[t]


def clear_sentiment():
    import vim

    index_of_sentiment_orientation = column_of("sentiment_orientation")

    (row, col) = vim.current.window.cursor
    lineVec = vim.current.buffer[row - 1].split("\t")
    lineVec[index_of_sentiment_orientation] = ""
    vim.current.buffer[row - 1] = "\t".join(lineVec)
    
def make_negative():
    import vim

    index_of_text = column_of("text")
    index_of_sentiment_orientation = column_of("sentiment_orientation")

    (row, col) = vim.current.window.cursor
    lineVec = vim.current.buffer[row - 1].split("\t")
    lineVec[index_of_sentiment_orientation] = "neg"
    vim.current.buffer[row - 1] = "\t".join(lineVec)

def make_positive():
    import vim

    index_of_text = column_of("text")
    index_of_sentiment_orientation = column_of("sentiment_orientation")

    (row, col) = vim.current.window.cursor
    lineVec = vim.current.buffer[row - 1].split("\t")
    lineVec[index_of_sentiment_orientation] = "pos"
    vim.current.buffer[row - 1] = "\t".join(lineVec)
EOF

