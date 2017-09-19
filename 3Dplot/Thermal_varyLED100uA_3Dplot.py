#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 18 14:15:05 2017

@author: Sujay
"""
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm

# Use SciPy io library to load the MATLAB file
import scipy.io
file = scipy.io.loadmat('thermal100uA.mat')
data = file['data']

ILED = data[:, 0]
Temp = data[:, 1]
VLED = data[:, 2]
PDout = data[:, 3]
NumILEDsteps = 40

X_ILED_list = ILED[:NumILEDsteps]
X_ILED = np.array(X_ILED_list)

Y_Temp_list = []
for i in range(int(len(Temp)/NumILEDsteps)):
    Temptemp = Temp[(i * NumILEDsteps + 10) - 1]
    Y_Temp_list.append(Temptemp)
Y_Temp = np.array(Y_Temp_list)

Z_PDout_list = []
for i in range(int(len(ILED)/NumILEDsteps)):
    rowtemp = PDout[i * NumILEDsteps:i * NumILEDsteps + NumILEDsteps]
    Z_PDout_list.append(rowtemp)
Z_PDout = np.array(Z_PDout_list)

X_ILED, Y_Temp = np.meshgrid(X_ILED, Y_Temp)


fig = plt.figure()
ax = fig.gca(projection='3d')

surf = ax.plot_surface(X_ILED, Y_Temp, Z_PDout, cmap=cm.coolwarm,
                       linewidth=0, antialiased=False)
fig.colorbar(surf, shrink=0.5, aspect=5)
ax.set_xlabel('ILED (mA)')
ax.set_ylabel('Temperature (degC)')
ax.set_zlabel('PDout (V)')

plt.show()