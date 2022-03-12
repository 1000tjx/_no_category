# coding: utf-8
user_list = []


def reDo(isUserList=False):
    list_length = int(raw_input("List Length: "))

    if(not isUserList):
        for pos in range(list_length):
            pos_dim = raw_input(
                'Do you want to set position[%d] as list ? [y/n]: ' % pos)
            if(pos_dim == 'n'):
                new_value = raw_input('Value At Posistion [%d]: ' % pos)
                user_list.append(new_value)
            else:
                reDo(True)
    else:
        temp_list = []
        for pos in range(list_length):
            pos_dim = raw_input(
                'Do you want to set position[%d] as list ? [y/n]: ' % pos)
            if(pos_dim == 'n'):
                new_value = raw_input('Value At Posistion [%d]: ' % pos)
                temp_list.append(new_value)
            else:
                reDo(True)
        user_list.append(temp_list)


reDo()
print "Your List: " + str(user_list)
