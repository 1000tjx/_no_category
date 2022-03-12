# coding: utf-8


def silt_clay_group(pass_200, ll, pi):
    if(get_group_classification(pass_200)):
        print('\n--Steps--')
        group = get_characteristics_of_fraction(ll, pi)
        usual_types = get_usual_types_of_significant(group)
        subgrade_rating = get_general_subgrade_rating(pass_200)
        print('\n--Solution--')
        print('*' * 20)
        print('Group Of Soil: %s' % group)
        print('Usual types of significant: %s' % usual_types)
        print('Subgrade rating: %s' % subgrade_rating)
        print('*' * 20)
    else:
        print("Unable to solve it !")
        exit()


def get_group_classification(a_pass_200):
    if(a_pass_200 >= 36):
        return True
    else:
        return False


def get_characteristics_of_fraction(a_ll, a_pi):
    group = ''
    if(a_ll <= 40 and a_pi <= 10):
        print('-' * 20)
        print('L.L <= 40 and P.I <= 10 -> Group is ( A-4 )')
        group = 'A-4'
    elif(a_ll >= 41 and a_pi <= 10):
        print('-' * 20)
        print('L.L >= 41 and P.I <= 10 -> Group is ( A-5 )')
        group = 'A-5'
    elif(a_ll <= 40 and a_pi >= 11):
        print('-' * 20)
        print('L.L <= 40 and P.I >= 11 -> Group is ( A-6 )')
        group = 'A-6'
    elif(a_ll >= 41 and a_pi >= 11):
        print('-' * 20)
        print('L.L >= 41 and P.I >= 11 -> Group is ( A-7-5 or A-7-6 )')
        group = 'A-7'

    if(group == 'A-7'):
        if(a_pi <= a_ll - 30):
            print('-' * 20)
            print('P.I <= L.L - 30 -> Group is ( A-7-5 )')
            group = 'A-7-5'
        else:
            print('-' * 20)
            print('P.I > L.L - 30 -> Group is ( A-7-6 )')
            group = 'A-7-6'
    return group


def get_usual_types_of_significant(group):
    print('-' * 20)
    print('If Group is [ A-4 or A-5 ] -> Silty Solis')
    print('-' * 20)
    print('If Group is [ A-6 or A-7-x ] -> Clayly Solis')
    if(group == 'A-4' or group == 'A-5'):
        return 'Silty Soils'
    else:
        return 'Clayly Soils'


def get_general_subgrade_rating(pass_200):
    if(pass_200 > 35):
        print('-' * 20)
        print('Passing of 200 > 35 » Fair to poor')
        return 'Fair to poor'
    else:
        print('-' * 20)
        print('Passing of 200 <= 35 » Excellent to good')
        return 'Excellent to good'


def solve():
    pass_200 = int(input('Percent of passing (200 opening): '))
    ll = int(input('L.L (Liquid Limit): '))
    pi = int(input('P.I (Plasticity Index): '))
    if(pass_200 > 35):
        silt_clay_group(pass_200, ll, pi)
    else:
        print('-' * 20)
        print('Not Coded Yet!')
        pass_10 = int(input('Percent of passing (10 opening): '))
        pass_40 = int(input('Percent of passing (40 opening): '))


if __name__ == '__main__':
    solve()
