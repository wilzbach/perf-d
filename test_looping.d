auto f_random_access(R)(R r)
{
    auto sum = 0;
    foreach (const i; 0 .. r.length)
    {
        sum += r[i];
    }
    return sum;
}

auto f_foreach(R)(R r)
{
    auto sum = 0;
    foreach (const el; r)
    {
        sum += el;
    }
    return sum;
}

auto f_foreach_ref(R)(R r)
{
    auto sum = 0;
    foreach (const ref el; r)
    {
        sum += el;
    }
    return sum;
}

auto f_for(R)(R r)
{
    import std.range;
    auto sum = 0;
    for (r.popFront(); !r.empty; r.popFront())
    {
        sum += r.front;
    }
    return sum;
}

void main() {
    import std.datetime: benchmark, Duration;
    import std.stdio: writeln, writefln;
    import std.array: array;
    import std.conv: to;
    import std.random: randomShuffle;
    import std.range:iota;
    auto arr = iota(100_000).array;
    arr.randomShuffle;

    auto i = 0;

    void f0(){ i += arr.f_random_access; }
    void f1(){ i += arr.f_foreach; }
    void f2(){ i += arr.f_foreach_ref; }
    void f3(){ i += arr.f_for; }
    auto rs = benchmark!(f0, f1, f2, f3)(10_000);
    foreach(j,r;rs)
    {
        version(GNU)
            writefln("%d %d secs %d ms", j, r.seconds(), r.msecs());
        else
            writeln(j, " ", r.to!Duration);
    }

    // prevent any optimization
    writeln(i);
}
