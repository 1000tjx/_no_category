# coding: utf-8

# File Content

# 70 1 4 130 322 0 2 109 0 2.4 2 3 3 present
# 67 0 3 115 564 0 2 160 0 1.6 2 0 7 absent
# 57 1 2 124 261 0 0 141 0 0.3 1 0 7 present
# 64 1 4 128 263 0 0 105 1 0.2 2 1 7 absent
# 74 0 2 120 269 0 2 121 1 0.2 1 1 3 absent


# File name
my_file = "file.txt"

# open file as read mode with UTF-8 encoding to support other language
f = open(my_file, encoding='utf-8', mode='r')
# Read all data from this file
lines_list = f.read()
# split data to arrays
lines_list = lines_list.split('\n')
# initilizing empty array
all_element = []
# Loop to add each line into empty array
for line in lines_list:
    # split line to multi values and put it in empty array
    all_element.append(line.split(" "))
    # print(line)

all_element = all_element[:-1]
# print(all_element)
print("\n\n10st value from frst line: is: %s" % all_element[0][9])
