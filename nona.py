# -*- coding: utf-8 -*-

import os  # noqa


def get_file_info(the_file):
    # checking if file exists
    if(os.path.isfile(the_file)):
        file = open(the_file, 'r')
        f_n_ext = os.path.splitext(the_file)
        filename = f_n_ext[0]
        # file_ext = f_n_ext[1]
        lines = file.readlines()
        file_byte_count = os.stat(the_file).st_size
        file_line_count = len(lines)
        file_word_count = 0
        for line in lines:
            for word in line.split():
                if(len(word) >= 1):
                    file_word_count += 1
        print("\n%d %d %d %s\n" % (file_line_count, file_word_count, file_byte_count, filename))  # noqa
        # print("\n")
        # print("-" * 10)
        # print("File Name: %s" % filename)
        # print("File Type: %s" % file_ext)
        # print("Byte Count: %s" % file_size)
        # print("Lines Count: %d" % file_lines_count)
        # print("Words Count: %d" % file_words_count)
        # print("-" * 10)
    else:
        print("\nfile not exists!\n")
        exit()


# file_path = raw_input('Insert File Path please: ')  # python2
file_path = input('Insert File Path please: ')  # python3

get_file_info(file_path)
