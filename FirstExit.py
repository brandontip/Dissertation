# -*- coding: utf-8 -*-
"""
Created on Mon Oct 26 10:10:10 2020

@author: btipp
"""

from mpmath import *
import matplotlib.pyplot as plt


N=1
r=1
exits = []
precisions = []

for prec in range(1,10):
    mp.dps = 10*prec  
    
    zeroeth = mp.quad(lambda x: mp.exp(-(N/2)*(x**2)-(N*r/4)*(x**4)), [-mp.inf, mp.inf])
    second = mp.quad(lambda x: (x**2)*mp.exp(-(N/2)*(x**2)-(N*r/4)*(x**4)), [-mp.inf, mp.inf])
    fourth = mp.quad(lambda x: (x**4)*mp.exp(-(N/2)*(x**2)-(N*r/4)*(x**4)), [-mp.inf, mp.inf])

    numerator = fadd(fmul(fourth,zeroeth), fmul(-second,second))
    denominator = fmul(second,zeroeth)
    
    init_x = fdiv(numerator,denominator)
    init_y =fdiv(second,zeroeth)
    
    
    current_x = init_x
    current_y = init_y
    
    positive= True
    n=2
    while positive:
        term_one = fdiv(n, fprod([N,r,current_x]))
        term_two = fdiv(-1,r)
        term_three = -current_x-current_y
        new_x = fsum([term_one,term_two,term_three])
        current_x ,current_y = new_x,current_x
        n+=1
        if current_x <0:
            break
    exits.append(n) 
    precisions.append(10*prec)
    
print(exits)
print(precisions)