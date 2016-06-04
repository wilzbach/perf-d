import std.range;

auto f_random_access(R)(R r, size_t needle)
{
    foreach (const i; 0 .. r.length)
    {
        if (r[i] == needle)
            return r[i .. $];
    }
    return r[$ .. $];
}

auto f_foreach(R)(R r, size_t needle)
{
    foreach (i, const el; r)
    {
        if (el == needle)
            return r[i .. $];
    }
    return r;
}

auto f_for(R)(R r, size_t needle)
{
    for (; !r.empty; r.popFront())
    {
        if (r.front == needle)
            return r; // note in std.algorithm `save` is used
    }
    return r;
}

void main() {
    import std.datetime: benchmark, Duration;
    import std.stdio: writeln;
    import std.array: array;
    import std.conv: to;
    import std.random: randomShuffle;
    import std.range:iota;
    auto arr = iota!size_t(100_000).array;
    arr.randomShuffle;
    auto needle = arr[arr.length / 2];

    auto i = 0;
    import std.exception;
    auto check(size_t el)
    {
        enforce(el == needle);
        i += el;
    }

    void f0(){ check(arr.f_random_access(needle).front); }
    void f1(){ check(arr.f_foreach(needle).front); }
    void f2(){ check(arr.f_for(needle).front); }
    auto rs = benchmark!(f0, f2, f1)(100_000);
    foreach(j,r;rs)
        writeln(j, " ", r.to!Duration);

    // prevent any optimization
    writeln(i);
}
