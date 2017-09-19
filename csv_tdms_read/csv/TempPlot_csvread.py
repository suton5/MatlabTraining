#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 18 16:09:38 2017

@author: Sujay
"""
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

data = np.genfromtxt('b141511.csv', delimiter=',')
data = np.delete(data, (0), axis=0)

TMP = data[:, 0]
LED = data[:, 1]
PD = data[:, 2]
time = np.linspace(0, 162, num=163)

plt.subplot(3, 1, 1)
plt.plot(time, TMP, 'r')
plt.title('TMP (deg C) vs Time (mins)')

plt.subplot(3, 1, 2)
plt.plot(time, LED, 'b')
plt.title('LED voltage (V) vs Time (mins)')

plt.subplot(3, 1, 3)
plt.plot(time, PD, 'b')
plt.title('PDout (V) vs Time (mins)')