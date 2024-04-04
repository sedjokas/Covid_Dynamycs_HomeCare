# -*- coding: utf-8 -*-
"""
Created on Mon Mar 18 12:04:06 2024

@author: hp
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from numpy import *
from matplotlib import cm
from matplotlib import animation
from matplotlib.ticker import LinearLocator, FormatStrFormatter
from mpl_toolkits import mplot3d
from mpl_toolkits.mplot3d import proj3d
from mpl_toolkits.mplot3d import Axes3D
x = pd.read_excel("Covid.xlsx", usecols="A", dtype=float, skiprows=0)
g09I=pd.read_excel("Covid.xlsx", usecols="B", dtype=float, skiprows=0)
g09D=pd.read_excel("Covid.xlsx", usecols="C", dtype=float, skiprows=0)
g08I=pd.read_excel("Covid.xlsx", usecols="D", dtype=float, skiprows=0)
g08D=pd.read_excel("Covid.xlsx", usecols="E", dtype=float, skiprows=0)
g07I=pd.read_excel("Covid.xlsx", usecols="F", dtype=float, skiprows=0)
g07D=pd.read_excel("Covid.xlsx", usecols="G", dtype=float, skiprows=0)
g06I=pd.read_excel("Covid.xlsx", usecols="H", dtype=float, skiprows=0)
g06D=pd.read_excel("Covid.xlsx", usecols="I", dtype=float, skiprows=0)
g05I=pd.read_excel("Covid.xlsx", usecols="J", dtype=float, skiprows=0)
g05D=pd.read_excel("Covid.xlsx", usecols="K", dtype=float, skiprows=0)
g04I=pd.read_excel("Covid.xlsx", usecols="L", dtype=float, skiprows=0)
g04D=pd.read_excel("Covid.xlsx", usecols="M", dtype=float, skiprows=0)
g03I=pd.read_excel("Covid.xlsx", usecols="N", dtype=float, skiprows=0)
g03D=pd.read_excel("Covid.xlsx", usecols="O", dtype=float, skiprows=0)
g02I=pd.read_excel("Covid.xlsx", usecols="P", dtype=float, skiprows=0)
g02D=pd.read_excel("Covid.xlsx", usecols="Q", dtype=float, skiprows=0)
g01I=pd.read_excel("Covid.xlsx", usecols="R", dtype=float, skiprows=0)
g01D=pd.read_excel("Covid.xlsx", usecols="S", dtype=float, skiprows=0)
g00I=pd.read_excel("Covid.xlsx", usecols="T", dtype=float, skiprows=0)
g00D=pd.read_excel("Covid.xlsx", usecols="U", dtype=float, skiprows=0)
X, Y1 = np.meshgrid(x['Cycles'],g09I['I1'])
X, Z1 = np.meshgrid(x['Cycles'],g09D['D1'])
X, Y2 = np.meshgrid(x['Cycles'],g08I['I2'])
X, Z2 = np.meshgrid(x['Cycles'],g08D['D2'])
X, Y3 = np.meshgrid(x['Cycles'],g07I['I3'])
X, Z3 = np.meshgrid(x['Cycles'],g07D['D3'])
X, Y4 = np.meshgrid(x['Cycles'],g06I['I4'])
X, Z4 = np.meshgrid(x['Cycles'],g06D['D4'])
X, Y5 = np.meshgrid(x['Cycles'],g05I['I5'])
X, Z5 = np.meshgrid(x['Cycles'],g05D['D5'])
X, Y6 = np.meshgrid(x['Cycles'],g04I['I6'])
X, Z6 = np.meshgrid(x['Cycles'],g04D['D6'])
X, Y7 = np.meshgrid(x['Cycles'],g03I['I7'])
X, Z7 = np.meshgrid(x['Cycles'],g03D['D7'])
X, Y8 = np.meshgrid(x['Cycles'],g02I['I8'])
X, Z8 = np.meshgrid(x['Cycles'],g02D['D8'])
X, Y9 = np.meshgrid(x['Cycles'],g01I['I9'])
X, Z9 = np.meshgrid(x['Cycles'],g01D['D9'])
X, Y10 = np.meshgrid(x['Cycles'],g00I['I10'])
X, Z10 = np.meshgrid(x['Cycles'],g00D['D10'])
fig = plt.figure(figsize=(10, 20))
ax=plt.axes(projection='3d')
#ax = fig.gca(projection='3d')
ax.set_xlabel('Time (Days)', font='Times New Roman', fontsize=10)
ax.set_ylabel('Infections', font='Times New Roman', fontsize=10)
ax.set_zlabel('Deaths', font='Times New Roman', fontsize=10)
ax.plot_wireframe(X,Y1,Z1, rstride=1, cstride=1, color="red", label="1-$\gamma$=0.9")
ax.plot_wireframe(X,Y2,Z2, rstride=1, cstride=1, color="blue", label="1-$\gamma$=0.8")
ax.plot_wireframe(X,Y3,Z3, rstride=1, cstride=1, color="green", label="1-$\gamma$=0.7")
ax.plot_wireframe(X,Y4,Z4, rstride=1, cstride=1, color="purple", label="1-$\gamma$=0.6")
ax.plot_wireframe(X,Y5,Z5, rstride=1, cstride=1, color="magenta", label="1-$\gamma$=0.5")
ax.plot_wireframe(X,Y6,Z6, rstride=1, cstride=1, color="pink", label="1-$\gamma$=0.4")
ax.plot_wireframe(X,Y7,Z7, rstride=1, cstride=1, color="yellow", label="1-$\gamma$=0.3")
ax.plot_wireframe(X,Y8,Z8, rstride=1, cstride=1, color="cyan", label="1-$\gamma$=0.2")
ax.plot_wireframe(X,Y9,Z9, rstride=1, cstride=1, color="brown", label="1-$\gamma$=0.1")
ax.plot_wireframe(X,Y10,Z10, rstride=1, cstride=1, color="orange", label="1-$\gamma$=0.0")
plt.tight_layout()
plt.legend(loc='upper right', fontsize=7)
#ax.view_init(30,45)
#ax.view_init(15,20)
plt.show()