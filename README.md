Testing the performance of ranges in D.
----------------------------------------

Do we really have zero-cost abstraction?
Let's test!

DMD
---

```
dmd -release -O -boundscheck=off test_looping.d && ./test_looping
```

LDC
---

```
ldc -release -O3 -boundscheck=off test_looping.d && ./test_looping
```


Current tests
--------------

- `test_looping` - simple iteration test between manual loop and range API
- `test_save` - tests performance when returning a range (common for search algorithms)
