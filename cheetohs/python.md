# Random Notes
* Do not let a function return `None` because other values also evaluate to `False`. It's likely better to raise an exception.
* Type annotations on functions are cool.
* When dealing with tricky iteration code check `itertools` documentation for functions that could help.

# Code Snippets
Using list comprehenions over `map` and `filter`. These are for writing clear, concise code. Though they always create a list of each value in the iterable. This can lead to memory problems when the input is very large.
```python
my_list = [1, 2, 3, 4 ,5, 6, 7, 8, 9, 10]

# Multiply each element by 2
print(list(map(lambda x: x * 2, my_list))) 
print([x * 2 for x in my_list])
# [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

# Filters out even numbers
print(list(filter(lambda x: x % 2 == 0, my_list))) 
print([x for x in my_list if x % 2 == 0])
# [2, 4, 6, 8, 10]
```

Generator expressions provide a more efficient way to deal with large input sequences by combining the best of both worlds of list comprehensions and generators. Generator expressions create a new interator intead of a new list. This reduces speed of creation and optimizes memory allocation. Keep in mind that these expressions are stateful.
```python
my_gen = (x for x in my_list)
print(next(my_gen))
```

When returning a list it's more OP to use a generator. They are clearer functions. Also, the function's working memory wont include all the output.
```python
def (echo):
    for index, letter in enumerate(echo):
        yield f'{index}: {letter}'
```

Use `timeit` to measure execution time of small code snippets.
```python
def test():
    if (the_word := english_words_dict.get('ghost')):
        return true
timeit.timeit('test()', setup='from __main__ import test')
```

When wanting to access the indices and the elements.
```python
my_list = [2, 4, 6, 8, 10]

for i, v in enumerate(my_list):
```

Iterate over multiple lists at same time.
```python
import itertools
for name, count in itertools.zip_longest(names, counts):
```

Use walrus operator to prevent repetition.
```python
if count := fresh_fruit.get('orange', 0):

if (count := fresh_fruit.get('orange', 0)) >= 2:

while fresh_fruit := pick_fruit():
```

Use a starred expression to catch-all when unpacking.
```python
ages = [2, 4, 6, 8, 10]
*others, second_oldest, oldest = ages
```

Reduce number of key accesses with the get method.
```python
if (fruits := grocery.get('fruits')):
    for fruit in fruits:
```

Clean trace decorator for debugging a func.
```python
def trace(func):
    def wrapper(*args, **kwargs):
        result = func(*args, **kwargs)
        print(f'{func.__name__}({args!r}, {kwargs!r})) '
              f'-> {result!r}')
        return result
    return wrapper

@trace
def myfunc(bananas):
```