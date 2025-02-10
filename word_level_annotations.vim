
map  ce :py3 remove_tag_utf8()<CR>
map ,2 :py3 unify_tags()<CR>

vmap cl c[@<c-r>"#GEO\|\|]<ESC>
vmap cd c[@<c-r>"#DATE\|\|]<ESC>
vmap cg c[@<c-r>"#ORG\|\|]<ESC>
vmap cn c[@<c-r>"#PERSON\|\|]<ESC>
vmap cr c[@<c-r>"#CURRENCY\|\|]<ESC>
vmap ,1 c[@<c-r>"#REPLACE_ME\|\|]<ESC>

py3 << EOF
def unify_tags():
    import vim
    import re

    content_regex = "([^#]+)"
    tag_regex = r"([^|]+\?{0,1})"
    norm_regex = "([^|]*)"
    single_word_regex_string = r"\[@" + content_regex + "#" + tag_regex + r"\|" + norm_regex + r"\|\]"
    single_word_regex = re.compile(single_word_regex_string)
    multi_word_regex_string = single_word_regex_string + r"([,\.]{0,1}\s*)" + single_word_regex_string
    multi_word_regex = re.compile(multi_word_regex_string)
    
    (row, col) = vim.current.window.cursor

    m = multi_word_regex.search(vim.current.buffer[row-1])

    content_left = m.group(1)
    tag_left = m.group(2)
    norm_left = m.group(3)

    space_between = m.group(4)

    content_right = m.group(5)
    tag_right = m.group(6)
    norm_right = m.group(7)

    final_norm = norm_left + norm_right

    value_before = m.group(0)
    value_after = "[@" + content_left + space_between + content_right + "#" + tag_left + "|" + final_norm + "|]"

    vim.current.buffer[row-1] = vim.current.buffer[row-1].replace(value_before, value_after)

    # Go back to where the cursor was
    vim.command(":cal cursor(" + str(row) + ", " + str(col) + ")")





# https://www.johndcook.com/blog/2019/09/09/how-utf-8-works/
# a byte of the form 110xxxxx says the first five bits of a Unicode character are 
# stored at the end of this byte, and the rest of the bits are coming in the next byte.
# A byte of the form 1110xxxx contains four bits of a Unicode character and says that the 
# rest of the bits are coming over the next two bytes.
# A byte of the form 11110xxx contains three bits of a Unicode character and says that
# the rest of the bits are coming over the next three bytes.
def remove_tag_utf8():
    import vim

    # The problem with the .cursor function is that it gives us the location on a byte array line
    # and not on a utf-8 line
    (row, col) = vim.current.window.cursor
    line_byte_array = bytearray(vim.current.buffer[row-1], "utf-8")
    i_utf8 = 0

    # Convert from i_ascii to i_utf
    i_ascii_to_i_utf8 = dict()

    for i, cur_col in enumerate(line_byte_array):
        bin_byte = bin(cur_col)
        i_ascii_to_i_utf8[i] = i_utf8
        if cur_col < 128 or str(bin_byte).startswith("0b1110") or str(bin_byte).startswith("0b11110") or str(bin_byte).startswith("0b110"):
            i_utf8 += 1

    col_ascii = col
    col = i_ascii_to_i_utf8[col]
    for cur_col in range(col, -1, -1):
        C = vim.current.buffer[row-1][cur_col]
        if C == "[":
            start_index = cur_col
            break

    for cur_col in range(col, 10000):
        if vim.current.buffer[row-1][cur_col] == "#":
            end_content = cur_col
            break

    for cur_col in range(col, 10000):
        if vim.current.buffer[row-1][cur_col] == "]":
            end_index = cur_col
            break

    vim.current.buffer[row - 1] = vim.current.buffer[row - 1][0:start_index] + vim.current.buffer[row - 1][start_index + 2:end_content] + vim.current.buffer[row - 1][end_index + 1:]

    # Go back to where the cursor was
    vim.command(":cal cursor(" + str(row) + ", " + str(col_ascii) + ")")

EOF

