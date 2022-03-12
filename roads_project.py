import matplotlib.pyplot as plt
import numpy as np

width = 10


def space_array(a, spacing):
    a = a.flatten()
    two_elements_space = (spacing / len(a)) + 2 * len(a)
    final_array = []
    for i in range(len(a)):
        if(i + 1 <= len(a) - 1):
            final_array.extend(np.linspace(a[i], a[i + 1], two_elements_space, endpoint=False))
        else:
            final_array.extend([a[i]])
    return np.array(final_array)


def calculate_dx_dy_idx(p):
    dx = p['x'][1:] - p['x'][:-1]
    dy = p['y1'] - p['y2']
    idx = np.argwhere(np.diff(np.sign(dy)) != 0).flatten()
    return (dx, dy, idx)


def draw(p, idx, areas):
    plt.figure(figsize=(10, 6))
    plt.plot(p['x'], p['y1'])
    plt.plot(p['x'], p['y2'])
    plt.plot(p['x'][idx], p['y2'][idx], 'ro', c='red')
    cut = plt.fill_between(p['x'], p['y1'], p['y2'], where=p['y1'] >= p['y2'], color='red',
                           alpha=0.05, interpolate=True)
    cover = plt.fill_between(p['x'], p['y1'], p['y2'], where=p['y1'] < p['y2'], color='green',
                             alpha=0.1, interpolate=True)
    plt.legend([cut, cover], ['CUT', 'COVER'])
    plt.title('{} CUT: {} cubic meters, and COVER: {} cubic meters.'.format(p['name'],
                                                                            round(areas['cut_area'] * width, 5),
                                                                            round(areas['cover_area'] * width, 5)))
    plt.xlabel('Distances')
    plt.ylabel('Levels')
    plt.show()
    # plt.save('{}.png'.format(p['name']))
    return True


def calculate_areas(dx, dy):
    pos_part = np.maximum(dy, 0)  # only keep positive part, set other values to zero
    neg_part = -np.minimum(dy, 0)  # only keep negative part, set other values to zero
    pos_dx = pos_part[1:] - pos_part[:-1]
    pos_dx[pos_dx < 0] *= -1
    neg_dx = neg_part[1:] - neg_part[:-1]
    neg_dx[neg_dx < 0] *= -1
    pos_area = np.trapz(pos_part, dx=dx)
    neg_area = np.trapz(neg_part, dx=dx)
    return {'cut_area': pos_area, 'cover_area': neg_area}


pathes = {
    'PATH 1': {
        'x': space_array(np.array([0, 5, 10, 13.5, 16.4, 20.6, 25.6, 29.6]) * 10, 1000),
        'y1': space_array(np.array([46, 46, 46, 48, 47, 47, 42, 40]), 1000),
        'y2': space_array(np.array([45] * 8), 1000),
    },
    'PATH 2': {
        'x': space_array(np.array([0, 5, 10, 15, 18, 23, 24.5]) * 10, 1000),
        'y1': space_array(np.array([46, 46.5, 48, 47, 48, 41, 40]), 1000),
        'y2': space_array(np.array([44.5] * 7), 1000),
    },
    'PATH 3': {
        'x': space_array(np.array([0, 5, 8.5, 13.5, 18.5, 23.5, 25.1]) * 10, 1000),
        'y1': space_array(np.array([46, 49, 50, 49, 48, 41, 40]), 1000),
        'y2': space_array(np.array([47.5] * 7), 1000),
    }
}

for k, p in pathes.items():
    p['name'] = k
    dx, dy, idx = calculate_dx_dy_idx(p)
    areas = calculate_areas(dx, dy)
    draw(p, idx, areas)
