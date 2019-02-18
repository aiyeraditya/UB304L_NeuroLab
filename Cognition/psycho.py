import os
import sys
import termios
import fcntl
import time
import cv2
import random
import matplotlib.pyplot as plt
import os
import numpy as np

def getch():
    import sys, tty, termios
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(sys.stdin.fileno())
        ch = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    return ch

def show_images():
    print("Enter name")
    user = input()
    print("When ready, press enter")
    j = input()
    input1 = []
    winname = "Image"
    img_names = os.listdir('images')
    img = ["transfer.jpg"]
    np.random.shuffle(img)
    for i in img_names:
        img.append(i)
    f = open(user + ".txt", "w")
    for i in img:
        print(i)
    cv2.namedWindow(winname)
    cv2.moveWindow(winname, 0,0)
    el = []
    for i in img:
        if i.endswith("jpg") == False:
            continue
        elif i == 'transfer.jpg':
            name = 'transfer.jpg'
        else:
            name = "images/" + i
        image = cv2.imread(name)
        print("Show This Image")
        cv2.imshow(winname, image)
        cv2.waitKey(1)
        start = time.time()
        try:
            input1.append(getch())
        except Exception as e:
            input1.append(None)
        end = time.time()
        elapsed = end - start
        el.append(elapsed)
        print(elapsed)
    cv2.destroyAllWindows()
    start = time.time()
    end = time.time()
    elapsed = end - start
    print(elapsed)
    print(input1)
    for i in range(len(input1)):
        f.write(input1[i] + ",")
        f.write(str(el[i]))
        f.write("\n")
    f.close()
    f = open(user + "order.txt", "w")
    for i in img:
        f.write(i + "\n")
    f.close()
    return user

def generate_images():
    print("Hello There")
    y = []
    z = []
    #y = random.sample(range(20), 10)
    #z = random.sample(range(20), 10)
    # for i in range(10):
    #     y.append(random.randint(0, 20))
    #     z.append(random.randint(0, 20))
    n = ["o" for i in range(len(y) - 1)]
    n.append("p")
    s = [0 for n in range(len(y))]
    fig, ax = plt.subplots()
    ax.scatter(z, y, s = s)
    for i, txt in enumerate(n):
        ax.text(z[i], y[i], txt, fontsize = 40)
    ax.axes.get_xaxis().set_visible(False)
    ax.axes.get_yaxis().set_visible(False)
    plt.show()

def analysis(name):
    order = open(name + "order.txt", 'r')
    lines = order.readlines()
    order.close()
    # Array Has the order in which images were shown
    array = []
    for i in lines:
        if(i.startswith("Slide")):
            array.append(int(i[5:-5]))
    answerkey = [0 for i in range(len(array))]
    # Defining Which Images are different(1) or not (0)
    for i in range(len(array)):
        if array[i] < 25:
            answerkey[i] = 1
        else:
            answerkey[i] = 0
    # Categorization
    category_density = [0 for i in range(len(array))]
    category_intensity = [0 for i in range(len(array))]
    for i in range(42):
        if(i < 12):
            category_density[i] = -1
        elif(i < 24):
            category_density[i] = 1
        else:
            category_density[i] = 0
        category_intensity[i] = i%3
    response = open(name + ".txt", 'r')
    lines = response.readlines()
    response.close()
    rp = []
    time = []
    for i in lines[2:]:
        res = i.split(',')
        print(res)
        if(res[0] == 'm'):
            rp.append(1)
        elif(res[0] == 'z'):
            rp.append(0)
        time.append(float(res[1]))
    f = open(name + "arranged.csv", "w")
    f.write("Image Number, Size, Density, Response, Time, Correct?\n")
    # Writing Things to File
    for i in range(len(array)):
        f.write(str(array[i]))
        f.write(",")
        f.write(str(category_intensity[array[i] - 1]))
        f.write(", ")
        f.write(str(category_density[array[i] - 1]))
        f.write(", ")
        f.write(str(rp[i]))
        f.write(", ")
        f.write(str(time[i]))
        f.write(", ")
        f.write(str((category_density[array[i] - 1] +  rp[i])%2))
        f.write("\n")
    f.close()

name = show_images()
analysis(name)


# Aditya
# Agnish
# Pratyusha
# Siddharth
# Divyoj
# Rohith
# Pallabi
# Rashmi
