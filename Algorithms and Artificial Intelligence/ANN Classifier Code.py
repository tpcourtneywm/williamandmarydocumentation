# -*- coding: utf-8 -*-
#"""
#Created on Tue Sep 14 20:47:42 2021

#@author: thoma
#"""

import matplotlib.pyplot as plt 
import numpy as np 
import pandas as pd 
import tensorflow as tf 
from sklearn.model_selection import train_test_split 
from sklearn import preprocessing  
from sklearn.preprocessing import StandardScaler 
from tensorflow.keras.models import Sequential 
from tensorflow.keras.layers import Dense 
from tensorflow.keras.utils import to_categorical 
from matplotlib import pyplot 
import datetime 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Load Data Section 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" #load dataset 
red_df = pd.read_csv("C:/Users/thoma/OneDrive/Documents/AI/M3/winequality-red.csv", delimiter = ";", header=0) 
white_df = pd.read_csv("C:/Users/thoma/OneDrive/Documents/AI/M3/winequality-white.csv", delimiter = ";",  header=0) 
# drop any missing values from the datasets 
red_df= red_df.dropna() 
red_df=red_df.values 
white_df = white_df.dropna() 
white_df=white_df.values 
#identify independent and dependent variables 
red_x = red_df[:,0:11] 
red_y = red_df[:,11] 
white_x = white_df[:,0:11] 
white_y = white_df[:,11] 
# Start the timer for run time 
start_time = datetime.datetime.now() 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Pretreat Data Section 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" #Scale the x variables for the red data set and white data set red_x_MinMax = preprocessing.MinMaxScaler() 
red_x_MinMax = preprocessing.MinMaxScaler() 
red_x = np.array(red_x).reshape((len(red_x), 11)) 
red_y = np.array(red_y).reshape((len(red_y), 1)) 
white_x_MinMax = preprocessing.MinMaxScaler() 
white_x = np.array(white_x).reshape((len(white_x), 11)) 
white_y = np.array(white_y).reshape((len(white_y), 1))
#transform the x variables into the MinMax function 
red_x = red_x_MinMax.fit_transform(red_x) 
red_x = red_x_MinMax.fit_transform(red_x) 
white_x = white_x_MinMax.fit_transform(white_x) 
white_x = white_x_MinMax.fit_transform(white_x) 
#assign the training and test data sources 
red_x_train, red_x_test, red_y_train, red_y_test = train_test_split(red_x,red_y,  test_size = 0.10) 
white_x_train, white_x_test, white_y_train, white_y_test =  train_test_split(white_x,white_y, test_size = 0.25) 
#fit the scaled data 
sc = StandardScaler(with_mean=True, with_std = True) 
sc.fit(red_x_train) 
sc.fit(white_x_train) 
red_x_train_std = sc.transform(red_x_train) 
red_x_test_std = sc.transform(red_x_test) 
white_x_train_std = sc.transform(white_x_train) 
white_x_test_std = sc.transform(white_x_test) 
#make the y variables categorical for our classification problem red_y_train = to_categorical(red_y_train) 
red_y_test = to_categorical(red_y_test) 
white_y_train = to_categorical(white_y_train) 
white_y_test = to_categorical(white_y_test) 
print("red_x_train.shape", red_x_train.shape) 
print("len(red_y_train)", len(red_y_train)) 
#print("train_lebels", red_y_train) 
print("white_x_train.shape", white_x_train.shape) 
print("len(white_y_train)", len(white_y_train)) 
#print("white_y_train", white_y_train) 
print("red_x_test.shape", red_x_test.shape) 
print("len(red_y_test)", len(red_y_test)) 
#print("red_y_test", red_y_test) 
print("white_x_test.shape", white_x_test.shape) 
print("len(white_y_test)", len(white_y_test)) 
print("white_y_test", white_y_test) 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Define Model Section 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" #initialize the model for the red wine dataset 
network_red = tf.keras.models.Sequential() 
#Add the first hidden layer specifying the input shape 
network_red.add(tf.keras.layers.Dense(200, activation='relu')) #Add a second hidden layer 
network_red.add(tf.keras.layers.Dense(200, activation='relu'))
network_red.add(tf.keras.layers.Dense(200, activation='softmax'))
network_red.add(tf.keras.layers.Dense(200, activation='sigmoid'))
network_red.add(tf.keras.layers.Dense(120, activation='relu')) #Add the output layer
network_red.add(tf.keras.layers.Dense(9, activation='softmax')) #compile the model 
network_red.compile(optimizer='rmsprop', 
 loss='categorical_crossentropy', 
 metrics=['accuracy']) 
#initialize the model for the white wine dataset 
network_white = tf.keras.models.Sequential() 
#Add the first hidden layer specifying the input shape 
network_white.add(tf.keras.layers.Dense(300, activation='relu'))
network_white.add(tf.keras.layers.Dense(300, activation='relu'))
network_white.add(tf.keras.layers.Dense(300, activation='relu')) 
network_white.add(tf.keras.layers.Dense(150, activation='relu')) #Add the output layer 
network_white.add(tf.keras.layers.Dense(10, activation='softmax')) #compile the model 
network_white.compile(optimizer='rmsprop', 
 loss='categorical_crossentropy', 
 metrics=['accuracy']) 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Fit Model Section 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" #Train the models 
red_train = network_red.fit(red_x_train_std, red_y_train, epochs=750, batch_size=1000, verbose=2, validation_split = 0.6) 
white_train = network_white.fit(white_x_train_std, white_y_train, epochs=750,  batch_size=2000, verbose=2, validation_split = 0.33) 
network_red.summary() 
network_white.summary() 
#pyplot.plot(network_red['accuracy'], color = 'green', label = "red wine") 
#pyplot.plot(network_white['accuracy'], color = 'red', label = "white  wine") 
# =============================================================================
#plt.xlabel("EPOCH'S") 
#plt.ylabel("Accuracy") 
#plt.title("Accuracy Graph") 
#plt.legend() 
#pyplot.show() 
# """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Show output Section 
# """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" #output the scores 
scores_red = network_red.evaluate(red_x_train_std, red_y_train, verbose=1) 
scores_white = network_white.evaluate(white_x_train_std, white_y_train, verbose=1)  
red_test_loss, red_test_acc = network_red.evaluate(red_x_test_std, red_y_test) 
print('red_test_loss:', red_test_loss) 
print('red_test_acc:', red_test_acc) 
white_test_loss, white_test_acc = network_white.evaluate(white_x_test_std,  white_y_test) 
print('white_test_loss:', white_test_loss) 
print('white_test_acc:', white_test_acc)
stop_time = datetime.datetime.now() 
print ("Time required for training:",stop_time - start_time) 
# # fix random seed for reproducibility 
seed = 7 
np.random.seed(seed) 
estimator_red = network_red.fit(red_x_train_std, red_y_train, epochs=8000,  verbose=2) 
estimator_white = network_white.fit(white_x_train_std, white_y_train,  epochs=150, verbose=1) 
print(estimator_red)
print(estimator_white)
# """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Show output Section 
# """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" # plot metrics 
# =============================================================================
pyplot.plot(estimator_red.history['acc'], color = 'green', label = "red  wine") 
pyplot.plot(estimator_white.history['acc'], color = 'blue', label = "white wine") 
plt.xlabel("EPOCH'S") 
plt.ylabel("Accuracy") 
plt.title("Accuracy Graph") 
plt.legend() 
pyplot.show()

