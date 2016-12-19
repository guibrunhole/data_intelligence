
# created by: Guilherme Brunhole - github.com/guibrunhole - gui.brunhole@gmail.com
# date: 2016/12/19

# Here we are talking about Liner Algebra, more specifically, vectors :)

def vector_add(v,w):
	"""sum correspondents elements"""
	return [v_i + w_i
				for v_i, w_i in zip(v,w)]

def vector_subtract(v,w):
	"""subtract correspondents elements"""
	return [v_i - w_i
				for v_i, w_i in zip(v,w)]			

def vector sum(vectors):
	"""sum all correspondent numbers"""
	result = vectors[0]
	for vector in vectors[1:]:
		result = vector_add(result, vector)
	return result

def scalar_multiply(c,v):
	"""c is a number, v is a vector"""
	return [c * v_i for v_i in v]


### Matrix

def shape(A):
	num_rows = len(A)
	num_cols = len(A[0]) if A else 0
	return num_rows, num_cols

def get_row(A,i):
	return A[i]

def get_column(A,j):
	return [A_i[j]
				for A_i in A]

def make_matrix(num_rows, num_cols, entry_fn):
	return [[entry_fn(i,j)
				for j in range(num_cols)]
				for i in range(num_rows)]