import std.range;
import std.traits;
import std.functional: unaryFun, binaryFun;

auto extremum_random(alias map = "a", alias selector = "a < b", Range,
                      RangeElementType = ElementType!Range)
                     (Range r, RangeElementType seedElement)
    if (isInputRange!Range && !isInfinite!Range &&
        !is(CommonType!(ElementType!Range, RangeElementType) == void))
{
    alias mapFun = unaryFun!map;
    alias selectorFun = binaryFun!selector;

    alias Element = ElementType!Range;
    alias CommonElement = CommonType!(Element, RangeElementType);
    alias MapType = Unqual!(typeof(mapFun(CommonElement.init)));

    Unqual!CommonElement extremeElement = seedElement;
    MapType extremeElementMapped = mapFun(extremeElement);

    foreach (const i; 0 .. r.length)
    {
        MapType mapElement = mapFun(r[i]);
        if (selectorFun(mapElement, extremeElementMapped))
        {
            extremeElement = r[i];
            extremeElementMapped = mapElement;
        }
    }
    return extremeElement;
}

auto extremum_range(alias map = "a", alias selector = "a < b", Range,
                      RangeElementType = ElementType!Range)
                     (Range r, RangeElementType seedElement)
    if (isInputRange!Range && !isInfinite!Range &&
        !is(CommonType!(ElementType!Range, RangeElementType) == void))
{

    alias mapFun = unaryFun!map;
    alias selectorFun = binaryFun!selector;

    alias Element = ElementType!Range;
    alias CommonElement = CommonType!(Element, RangeElementType);
    alias MapType = Unqual!(typeof(mapFun(CommonElement.init)));

    Unqual!CommonElement extremeElement = seedElement;
    MapType extremeElementMapped = mapFun(extremeElement);


    while (!r.empty)
    {
        MapType mapElement = mapFun(r.front);
        if (selectorFun(mapElement, extremeElementMapped))
        {
            extremeElement = r.front;
            extremeElementMapped = mapElement;
        }
        r.popFront();
    }
    return extremeElement;
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

    void f0(){ i += arr.extremum_random(0); }
    void f1(){ i += arr.extremum_range(0); }
    auto rs = benchmark!(f0, f1)(50_000);
    foreach(j,r;rs)
        version(GNU)
            writefln("%d %d secs %d ms", j, r.seconds(), r.msecs());
        else
            writeln(j, " ", r.to!Duration);

    // prevent any optimization
    writeln(i);
}
