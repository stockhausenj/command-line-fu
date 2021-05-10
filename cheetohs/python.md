Using list comprehenions over `map` and `filter`. These are for writing clear, concise code. Though they always creates a list of each value in the iterable. This can lead to memory problems when the input is very large.

```
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

```
my_gen = (x for x in my_list)
```
