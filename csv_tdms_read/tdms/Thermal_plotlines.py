#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 18 17:45:32 2017

@author: Sujay
"""

import scipy.io
from nptdms import TdmsFile
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

file = scipy.io.loadmat('thermalLEDonly.mat')
data = file['data']

# Alternatively, use Python's Tdms File reader
#tdms_file = TdmsFile("thermalLEDonly.tdms")

ILED = data[:, 0]
Temp = data[:, 1]
VLED = data[:, 2]
PDout = data[:, 3]

X_ILED = ILED[:20]

Y_Temp = []
for i in range(int(len(Temp)/20)):
    Temptemp = Temp[(i * 20 + 10) - 1]
    Y_Temp.append(Temptemp)
    
#1st Graph
Y_Vf = []
for i in range(20):
    for j in range(int(len(Temp)/20)):
        Y_Vftemp = VLED[(j * 20) + i]
        Y_Vf.append(Y_Vftemp)
    plt.plot(Y_Temp, Y_Vf, 'b')
    Y_Vf = []
plt.xlabel('Temp (deg C)')
plt.ylabel('Vf (V)')
plt.title('Vf vs Temp at ILED = 1mA to 20mA')
plt.show()

#2nd Graph
for i in range(int(len(Temp)/20)):
    Y_Vftemp = VLED[(i * 20) + 10]
    Y_Vf.append(Y_Vftemp)
    
p_coeff = np.polyfit(Y_Vf, Y_Temp, 1)
Tcal = np.polyval(p_coeff, Y_Vf)

plt.plot(Y_Temp, Tcal, 'r')

Y_Vf = []

plt.plot(Y_Temp, Y_Temp, 'k--')
plt.xlabel('Temp (deg C)')
plt.ylabel('Calibrated Temp (deg C)')
plt.title('Plot Temp vs Poly Fitted Curve for ILED=10mA')
plt.show()

#3rd Graph
for i in range(20):
    for j in range(int(len(Temp)/20)):
        Y_Vftemp = VLED[(j * 20) + i]
        Y_Vf.append(Y_Vftemp)
     
    p_coeff = np.polyfit(Y_Vf, Y_Temp, 1)
    Tcal = np.polyval(p_coeff, Y_Vf)
    Err = Tcal - Y_Temp
    plt.plot(Y_Temp, Err, 'b')
    Y_Vf = []
plt.xlabel('Temp (deg C)')
plt.ylabel('Error (deg C)')
plt.title('Error vs Temp at ILED (fit each) = 1mA to 20mA')    
plt.show()