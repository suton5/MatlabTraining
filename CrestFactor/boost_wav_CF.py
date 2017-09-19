#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 19 13:30:24 2017

@author: Sujay
"""
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import soundfile as sf

Rl = 13                                 
eff_amp = 0.9                                 
eff_boost = 0.9                                
Vin = 2.5                                 
ILIM = 1.2                               
boost_V_nom = 10
E_amp_gain = 1.5/0.08
R_bat_trace = 0.5
R_bat_source = 0.05
Rdson_output = 0.1
line_width = 1
A_clip = 0.1
clip_tolerance = 0.0001
cap_array = [0]*3
cap_array[0] = 3.92*(10**(-6))
cap_array[1] = cap_array[0] + 10*(10**(-6))
cap_array[2] = cap_array[0] + 22*(10**(-6))
cap=cap_array[2]
capuF=cap*1e6
capuF=round(capuF)
Fs = 0.5*(10**6)
Ts = 1/Fs

y, Fwav = sf.read('PostProcessed.wav')

rms = np.sqrt(np.mean(np.square(y)))
CrestF = 20 * np.log10(max(y) / rms)

NFFT = 2**15
y_window = y[:NFFT]
Y = (np.fft.fft(y_window, NFFT)) / len(y_window)
f = (Fwav / 2) * np.linspace(0, 1, (NFFT/2)+1)
Y_half = 2 * np.absolute(Y[:int((NFFT/2) + 1)])

plt.plot(f, Y_half, 'b')
plt.xlabel('Frequency (Hz)')
plt.ylabel('|Y(f)|')
plt.title('Single-Sided Amplitude Spectrum of Voice .wav')
plt.show()