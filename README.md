Testing the performance of ranges in D.
----------------------------------------

Do we really have zero-cost abstraction?
Let's test!

Build & run
-----------

```
make test_looping
```

Or any of the tests available

Current tests
--------------

- `test_looping` - simple iteration test between manual loop and range API
- `test_save` - tests performance when returning a range (common for search algorithms)
- `test_extremum` - different specializations of `std.algorithm.searching.extremum`
