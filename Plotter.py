# -*- coding: utf-8 -*-
"""
Created on Mon Oct 26 10:03:18 2020

@author: btipp
"""

from mpmath import *
import matplotlib.pyplot as plt
mp.dps = 20


N=1
r=1


zeroeth = mp.quad(lambda x: mp.exp(-(N/2)*(x**2)-(N*r/4)*(x**4)), [-mp.inf, mp.inf])
second = mp.quad(lambda x: (x**2)*mp.exp(-(N/2)*(x**2)-(N*r/4)*(x**4)), [-mp.inf, mp.inf])
fourth = mp.quad(lambda x: (x**4)*mp.exp(-(N/2)*(x**2)-(N*r/4)*(x**4)), [-mp.inf, mp.inf])


print(zeroeth)
numerator = fadd(fmul(fourth,zeroeth), fmul(-second,second))
denominator = fmul(second,zeroeth)

init_x = fdiv(numerator,denominator)
init_y =fdiv(second,zeroeth)

iterates = 600
first_recorded = 2
last_recorded = iterates
recorded = []

current_x = init_x
current_y = init_y


for n in range(2,iterates):
    term_one = fdiv(n, fprod([N,r,current_x]))
    term_two = fdiv(-1,r)
    term_three = -current_x-current_y
    new_x = fsum([term_one,term_two,term_three])
    current_x ,current_y = new_x,current_x
    recorded.append(current_x)
    

plt.scatter(recorded[1:],recorded[:-1])
#plt.axis([xmin,xmax,ymin,ymax])
