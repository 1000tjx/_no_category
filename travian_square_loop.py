import numpy as np

x, y = (0, 0)
fields = 2

def square_arround(x, y, fields):
    top_right = (x + fields, y + fields)
    bottom_left = (x - fields, y - fields)

    data = [top_right, bottom_left]

    for i in range(1, fields * 2 + 1):
        xi, yi = top_right
        data.append((xi - i, yi))
        data.append((xi, yi - i))

    for i in range(1, fields * 2):
        xi, yi = bottom_left
        data.append((xi + i, yi))
        data.append((xi, yi + i))

    return data

def area_arround(x, y, fields):
    data = []
    for i in range(1, fields + 1):
        data.extend(square_arround(x, y, i))
    return data

def map_url(x, y):
    return 'https://norules.arabics.travian.com/karte.php?x=%d&y=%d' % (x, y)
