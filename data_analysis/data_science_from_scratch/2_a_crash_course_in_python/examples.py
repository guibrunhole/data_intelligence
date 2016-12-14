
# created by: Guilherme Brunhole - github.com/guibrunhole - gui.brunhole@gmail.com
# date: 2016/12/12

############
## tuples ##
############

my_list = [1,2]
my_tuple = (1,2)
other_tuple = 3,4
my_list[1] = 3

try:
	my_tuple[1] = 3
except TypeError:
	print "cannot modify a tuple"

def sum_and_product(x,y):
	return (x+y),(x*y)

sp = sum_and_product(2,3)
s,p = sum_and_product(2,3)

x, y = 1, 2
x, y = y, x


##########
## Dict ##
##########

tweet = {
	"user" : "joelgrus",
	"text" : "Data Science is Awesome",
	"retweet_count" : 100,
	"hastags" : ["#data", "#science", "#datascience", "#awesome", "#yolo"]
}

tweet_keys = tweet.keys()
print tweet_keys
# ['text', 'retweet_count', 'hastags', 'user']

tweet_values = tweet.values()
print tweet_values
# ['Data Science is Awesome', 100, ['#data', '#science', '#datascience', '#awesome', '#yolo'], 'joelgrus']

tweet_items = tweet.items()
print tweet_items
# [('text', 'Data Science is Awesome'), ('retweet_count', 100), ('hastags', ['#data', '#science', '#datascience', '#awesome', '#yolo']), ('user', 'joelgrus')]

# word counter
word_counts = {}
for word in document:
	if word in word_counts:
		word_counts[word] += 1
	else:
		word_counts[word] = 1

# Counter
from collections import Counter
c = Counter([0,1,2,0])
print c
# Counter({0: 2, 1: 1, 2: 1})

##########
## Sets ##
##########

s = set()