# Foreward

Foreward is a Lua library of functional programming helpers, inspired by LiveScript, Haskell and Clojure.

## Lists

### len (length) (count)
Returns length of the list or string.

    len({1, 2, 3})
    => 3
    len("hey")
    => 3

### cat (concat)
Concatenates lists.

    cat({1, 2}, {3, 4})
    => {1, 2, 3, 4}

### conj
Returns new list with items added to the end.

    conj(1, 2, {3, 4})
    => {3, 4, 1, 2}

### each
Applies a function to each item in the list and returns the original list. Used for side effects.

    each(function(x) print(x) end, {1, 2, 3})
    => 1 2 3

### map
Applies a function to each item in the list, and produces a new list with the results. The length of the result is the same length as the input.

    map(function(x) return x + 1 end, {1, 2, 3})
    => {2, 3, 4}

### compact
Returns a new list which contains only the truthy values of the inputted list.

    compact({0, 1, false, nil, "", "ha"})
    => {0, 1, "", "ha"}

### filter
Returns a new list composed of the items which pass the supplied function's test.

    filter(function(x) return even(x) end, {1, 2, 3})
    => {2}

### reject
Like filter, but the new list is composed of all the items which fail the function's test.

    reject(function(x) return even(x) end, {1, 2, 3})
    => {1, 3}

### fold (reduce)
Takes a list of items, and using the binary function supplied, folds them into a single value. Requires an initial value (the second argument), which will be the starting point, and result in case of an empty list.

    fold(function(x, y) return x + y end, 0, {1, 2, 3})
    => 6

### sum
Sums up the values in the list.

    sum({1, 2, 3})
    => 6

### prod (product)
Gets the product of all the items in the list.

    prod({1, 2, 3})
    => 6

### mean (average)
Gets the mean of the values in the list.

    mean({1, 2, 3})
    => 2

### flat (flatten)
Flattens a list which contains sub lists and elements of arbitrary depth into a list of elements with no sub lists.

    flat({1, {{2}, 3}, {4, {{5}}}})
    => {1, 2, 3, 4, 5}

### slice
Returns a slice of a list.

    slice(2, 4, {1, 2, 3, 4, 5})
    => {3, 4}

### zip
Zips together its two arguments into a list of lists.

    zip({1, 2, 3}, {4, 5, 6})
    => {{1, 4}, {2, 5}, {3, 6}}

### range
A function to create flexibly-numbered lists of integers, handy for each and map loops. start, if omitted, defaults to 1; step defaults to 1. Returns a list of integers from start to stop, incremented (or decremented) by step, exclusive. Note that ranges that stop before they start are considered to be zero-length instead of negative — if you'd like a negative range, use a negative step.

    range(5)
    => {1, 2, 3, 4, 5}

### head (first)
The first item of the list. Returns nil if the list is empty.

    head({1, 2, 3, 4, 5})
    => 1

### last
The last item of the list. Returns nil if the list is empty.

    last({1, 2, 3, 4, 5})
    => 5

### init (initial)
Everything but the last item of the list.

    init({1, 2, 3, 4, 5})
    => {1, 2, 3, 4}

### tail
Everything but the first item of the list.

    tail({1, 2, 3, 4, 5})
    => {2, 3, 4, 5}

### rev (reverse)
Returns a new list which is the reverse of the inputted one.

    rev({1, 2, 3, 4, 5})
    => {5, 4, 3, 2, 1}

### sort
Sorts a list. Does not modify the input.

    sort({3, 1, 2})
    => {1, 2, 3}

### uniq (unique) (distinct)
Returns a new list which contains each value of the inputted list only once.

    uniq({1, 1, 3, 2})
    => {1, 3, 2}

### part (partition)
Equivalent to {filter(f, xs), reject(f, xs)}, but more efficient, using only one loop.

    part(function(x) return even(x) end, {1, 2, 3, 4, 5})
    => {{2, 4}, {1, 3, 5}}

### without
Returns a copy of the array with all instances of the values removed.

    without(0, 1, {1, 2, 1, 0, 3, 1, 4})
    => {2, 3, 4}

### union
Produces a new list containing all the elements of all the inputted lists only once.

    union({1, 5, 7}, {3, 5})
    => {1, 5, 7, 3}

### same (intersection)
Produces a new list containing all the items which are present in all the lists.

    same({1, 2, 3}, {101, 2, 1, 10})
    => {1, 2}

### diff (difference)
Returns a new list containing the elements which are present in the first list and not in the others. This function is not curried as it takes a variable number of arguments.

    diff({1, 2, 3}, {1})
    => {2, 3}

### take
Returns the first n items in the list.

    take(2, {1, 2, 3, 4, 5})
    => {1, 2}

### drop
Returns the result of dropping the first n items of the list.

    drop(2, {1, 2, 3, 4, 5})
    => {3, 4, 5}

### at (nth)
Gets the element at the nth index (the first argument). If negative, will work from the end.

    nth(2, {1, 2, 3, 4, 5})
    => 2

### index
Returns the index at which value can be found in the array, or nil if value is not present in the array.

    index(2, {1, 2, 3, 4, 5})
    => 2

### find
Returns the first item in list to pass the function's test. Returns nil if all items fail the test.

    find(odd, {2, 3, 4 ,5})
    => 3

### shuffle
Returns a shuffled list.

    shuffle({1, 2, 3, 4})
    => {2, 4, 1, 3}

### sample
Produce a random sample from the list. Pass a number to return n random elements from the list. Otherwise a single random item will be returned.

    sample({1, 2, 3, 4, 5})
    => 4
    sample(3, {1, 2, 3, 4, 5})
    => {1, 4, 2}

### least (minimum)
Takes a list of comparable items, and returns the smallest of them.

    least({"c", "e", "a", "d", "b"})
    => "a"

### most (maximum)
Takes a list of comparable items, and returns the largest of them.

    most({4, 1, 9, 3})
    => 9

### has (contains)
Returns true if the value is present in the list.

    has(3, {1, 2, 3, 4, 5})
    => true

### all (every)
Returns true if all the items in the list are true when applied to the test.

    all(odd, {1, 2, 3, 4, 5})
    => false

### any (some)
Returns true if any of the items in the list are true when applied to the test.

    any(odd, {1, 2, 3, 4, 5})
    => true

### empty
Whether the list is empty.

    empty({})
    => true


## Numbers

### dec
Returns value minus 1.

    dec(10)
    => 9

### inc
Returns value plus 1.

    inc(10)
    => 11

### neg
The negation of the inputted number.

    neg(1)
    => -1

### quot
Division truncated toward 0.

    quot(-20, 3)
    => -6

### rem
Remainder, like the % operator.

    rem(-20, 3)
    => -2

### div
Division truncated down toward negative infinity.

    div(-20, 3)
    => -7

### mod
Provides true mathematical modulo.

    mod(-20, 3)
    => 1

### even
Is the number even?

    even(4)
    => true

### odd
Is the number odd?

    odd(3)
    => true

### gcd
Greatest common denominator.

    gcd(12, 18)
    => 6

### lcm
Least common multiple.

    lcm(12, 18)
    => 36


## Strings

### split
Splits a string on a separator into a list of strings.

    split("|", "1|2|3")
    => {"1", "2", "3"}

### join
Joins a list with the specified separator.

    join("|", {1, 2, 3})
    => "1|2|3"

### lines
Splits a string at newlines into a list.

    lines("one\ntwo\nthree")
    => {"one", "two", "three"}

### unlines
Joins a list of strings into a single string using newlines.

    unlines({"one", "two", "three"})
    => "one\ntwo\nthree"

### words
Splits a string at spaces (one or more), returning a list of strings.

    words("hello, how are you?")
    => {"hello,", "how", "are", "you?"}

### unwords
Joins a list of strings into a single string using spaces.

    unwords({"one", "two", "three"})
    => "one two three"

### chars
Splits a string at every character, returning a list of one character strings.

    chars("hello")
    => {"h", "e", "l", "l", "o"}

### unchars
Joins a list of strings into a single string using no separator.

    unchars({"h", "e", "l", "l", "o"})
    => "hello"

### capitalize
Capitalizes a string.

    capitalize("hello, how are you?")
    => "Hello, how are you?"


## Functions

### apply
Returns the application of the supplied list as arguments to the supplied function.

    apply(math.min, {2, 5, 1})
    => 1
