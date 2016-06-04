Testing the performance of ranges in D.
----------------------------------------

Do we really have zero-cost abstraction?
Let's test!

DMD
---

```
dmd -inline -release -O -boundscheck=off test_looping.d && ./test_looping
```

LDC
---

```
ldc -inline -release -O3 -boundscheck=off test_looping.d && ./test_looping
```


Current tests
--------------

- `test_looping` - simple iteration test between manual loop and range API
- `test_save` - tests performance when returning a range (common for search algorithms)
- `test_extremum` - different specializations of `std.algorithm.searching.extremum`
