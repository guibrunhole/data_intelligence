#!/usr/bin/python

import sys
import pickle
sys.path.append("/guibrunhole/data_intelligence/data_analysis/nanodegree_udaciy/P5-machine_learnig/ud120-projects/tools/")
sys.path.append("/guibrunhole/data_intelligence/data_analysis/nanodegree_udaciy/P5-machine_learnig/ud120-projects/final_project/")

from feature_format import featureFormat, targetFeatureSplit
from tester import dump_classifier_and_data

import pandas as pd

from sklearn.preprocessing import MinMaxScaler
from sklearn.feature_selection import SelectPercentile,f_classif
from sklearn.feature_extraction.text import TfidfVectorizer,CountVectorizer


def computeFractionPoi(data_dict):

    for name in data_dict:

		from_poi_to_this_person = data_dict[name]["from_poi_to_this_person"]
		from_this_person_to_poi = data_dict[name]["from_this_person_to_poi"]
		to_messages = data_dict[name]["to_messages"]

		to_messages = (0 if to_messages == 'NaN' else to_messages)
		from_this_person_to_poi = (0 if from_this_person_to_poi == 'NaN' else from_this_person_to_poi)
		from_poi_to_this_person = (0 if from_poi_to_this_person == 'NaN' else from_poi_to_this_person)

		if to_messages == 0:
			fraction_to_poi = 0
			fraction_from_poi = 0
		else:
			fraction_to_poi = float(from_poi_to_this_person)/float(to_messages)
			fraction_from_poi = float(from_poi_to_this_person)/float(to_messages)

		data_dict[name]["fraction_to_poi"] = fraction_to_poi
		data_dict[name]["fraction_from_poi"] = fraction_from_poi

    return data_dict

### Task 1: Select what features you'll use.
### features_list is a list of strings, each of which is a feature name.
### The first feature must be "poi".

### Load the dictionary containing the dataset
with open("/guibrunhole/data_intelligence/data_analysis/nanodegree_udaciy/P5-machine_learnig/ud120-projects/final_project/final_project_dataset.pkl", "r") as data_file:
    data_dict = pickle.load(data_file)

### Task 2: Remove outliers
data_dict.pop('TOTAL')

### Task 3: Create new feature(s)
### creating fraction_to_poi and fraction_from_poi how we saw at the class
new_data_dict = computeFractionPoi(data_dict)

df_data = pd.DataFrame.from_dict(new_data_dict, orient='index')
df = df_data[df_data.email_address != 'NaN']

total_size= len(df_data)
total_poi = df_data[df_data.poi]
print 'Total de registros: ', total_size
print 'Total de poi: ',len(total_poi)
print 'Total de nao-poi: ',total_size - len(total_poi)
print 'Total de atributos:', len(df_data.columns)

cols = df.columns.tolist()
# len(cols) 23
cols.remove('email_address')
cols.remove('poi') # removing this feature for predict it

final = df[cols].copy().applymap(lambda x: 0  if x == 'NaN' else x) #replace NaN features as 0

#Verificando, para pessoa, o peso de cada feature
scaled = final.apply(MinMaxScaler().fit_transform) 

selPerc = SelectPercentile(f_classif,percentile=25) # Built the SelectPercentile
selPerc.fit(scaled,df['poi']) # Learn the Features, knowing which features to use

features_percentiled = scaled.columns[selPerc.get_support()].tolist() #Filter columns based on what Percentile support
scaled['poi'] = df['poi'] #rejoin the label

features_percentiled # most valuable features

features_list = ['poi'] +features_percentiled # You will need to use more features

features_list

### Store to my_dataset for easy export below.
my_dataset = df.to_dict(orient="index")

my_dataset

### Extract features and labels from dataset for local testing
data = featureFormat(my_dataset, features_list, sort_keys = True)
labels, features = targetFeatureSplit(data)

### Task 4: Try a varity of classifiers
### Please name your classifier clf for easy export below.
### Note that if you want to do PCA or other multi-stage operations,
### you'll need to use Pipelines. For more info:
### http://scikit-learn.org/stable/modules/pipeline.html

# Provided to give you a starting point. Try a variety of classifiers.

### Naive Bayes
from sklearn.naive_bayes import GaussianNB
clf = GaussianNB()

clf.fit(features, labels)
acc_naive = clf.score(features, labels)

# print "Naive Bayes accuracy is: ", acc_naive

### Decision Tree
from sklearn.tree import DecisionTreeClassifier
clf = DecisionTreeClassifier()

clf.fit(features, labels)
acc_tree = clf.score(features, labels)

# print "Decision Tree accuracy is: ", acc_tree

### Random Forest
from sklearn.ensemble import RandomForestClassifier
clf = RandomForestClassifier()

clf.fit(features, labels)
acc_rf = clf.score(features, labels)

# print "Random Forest accuracy is: ", acc_rf

### Linear Model
from sklearn.linear_model import SGDClassifier
clf = SGDClassifier(n_jobs=10)

clf.fit(features, labels)
predict = clf.predict(features)
acc_lm = clf.score(features, labels)

# print "Linear Model accuracy is: ", acc_lm

### Task 5: Tune your classifier to achieve better than .3 precision and recall 
### using our testing script. Check the tester.py script in the final project
### folder for details on the evaluation method, especially the test_classifier
### function. Because of the small size of the dataset, the script uses
### stratified shuffle split cross validation. For more info: 
### http://scikit-learn.org/stable/modules/generated/sklearn.cross_validation.StratifiedShuffleSplit.html

# splitting our data
from sklearn.cross_validation import train_test_split
features_train, features_test, labels_train, labels_test = \
    train_test_split(features, labels, test_size=0.3, random_state=42)
    
### Naive Bayes
clf = GaussianNB()

clf.fit(features_train, labels_train)
acc_naive = clf.score(features_test, labels_test)

# print "Naive Bayes accuracy is: ", acc_naive

### Decision Tree
clf = DecisionTreeClassifier()

clf.fit(features_train, labels_train)
acc_tree = clf.score(features_test, labels_test)

# print "Decision Tree accuracy is: ", acc_tree

### Random Forest
clf = RandomForestClassifier()

clf.fit(features_train, labels_train)
acc_rf = clf.score(features_test, labels_test)

# print "Random Forest accuracy is: ", acc_rf

### Linear Model
clf = SGDClassifier()

clf.fit(features_train, labels_train)
acc_lm = clf.score(features_test, labels_test)

# print "Linear Model accuracy is: ", acc_lm

################################################

from sklearn import svm, datasets
from sklearn.metrics import precision_recall_curve
from sklearn.metrics import average_precision_score
from sklearn.metrics import recall_score
from sklearn.grid_search import GridSearchCV
from sklearn.cross_validation import StratifiedShuffleSplit

### DecisionTree
# clf = DecisionTreeClassifier()

### RandomForest
# clf = RandomForestClassifier() # toooooooooo slow

# ### SDGClassifer 
### Utilizando GridSearchCV para tuning do modelo com SGDClassifier, porem ainda assim o modelo com NaiveBayes foi superior
# sgd = SGDClassifier(penalty='l2',random_state=42)
# parameters = {'loss': ['hinge','log','squared_hinge'],
#               'n_iter': [1,5],
#               'alpha': [1e-2, 1e-4 ,1e-6],
#               }
# clf = GridSearchCV(sgd,parameters,scoring='f1',cv=10)

# using cross validation
cv = StratifiedShuffleSplit(df.poi,10,random_state=42)

# ### Naive Bayes
clf = GaussianNB() # => best result, check it on my_review.txt

#################################################
#################################################
### Task 6: Dump your classifier, dataset, and features_list so anyone can
### check your results. You do not need to change anything below, but make sure
### that the version of poi_id.py that you submit can be run on its own and
### generates the necessary .pkl files for validating your results.

dump_classifier_and_data(clf, my_dataset, features_list)