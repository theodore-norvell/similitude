# Values in Similitude

# Instantaneous values

Each instantaneous value is of one of 2 kinds

* Scalar
* Vector


## Scalar values
There are 5 scalar values: $H$, $L$, $Z$, $X$, and $E$.

These are arranged in a semilattice such that

* $E < x$ for all $x$ in ${H,L,Z,X}$ 
* $X < x$ for all $x$ in ${H,L,Z}$
* $y \ge x$ in all other cases
  
Scalar values have depth 0.

### Explanation

$H$ represents a high voltage state. $L$ represents a low voltage state. $Z$ represents a high impedance state. $Z$ is used for tri-state output and is also the output value for input gates.

$E$ represents any kind of error condition.  Errors should not happen in a well designed circuit that is used properly. So errors should only arise from bad design or bad use. $E$ values in practice are associated with zero or more error messages.

Finally $X$ represents an unknown or don't care value.  Certain devices may output an unknown value when they are in transition. For example if a device has a minimum delay $\delta_0$ and a maximum delay $\delta_1$, then, if an input change at time $t$ causes a state change in the output, then the value of the output will be unknown from time $t+\delta_0$ to time $t+\delta_1$. 

Another role for $X$ is as a don't care for an expected output. When we specify a decoder, it might be that we don't care what its output is for certain inputs. We might not care what the output is, but we do care that it's not an error, so we should test the device on those inputs, but give $X$ as the expected output for inputs where we don't care about the value.  Another example is where a specification is loose about time.  Say we need a device to react within 10 ns, but it's ok it it's faster.  Then the expected output would be given as $X$ from the time the input changes until 10 ns after that.

Finally, we can use don't care values to fill out the signal values. This allows us to use total functions for signal values and we can give a don't care value the times that we really aren't interested in.

### Resolution

During simulation, values from various ports need to be resolved.


## Vector values
A vector value is a sequence of 0 or more instantaneous values, called its items, each with lesser depth. The depth of a vector is 1 plus the depth of its deepest item.  The length of a vector is the number of children it has. For example $[H,L,[ ]]$ is a tuple of length 3 and depth 2.  Tuples are written in Arabic order, e.g., item 0 of $[H,L,[]]$ is $[]$, item 1 is $L$ and item 2 is $H$.

### Explanation

Often in circuit diagrams we use one net --a net is a maximal set of connected links-- to represent multiple parallel wires.  If similitude had strong typing (like VHDL), then we would perhaps indicate, for one link in each net, how many wires it represents. However that would mean that we could't reuse the same component for different widths.  The VHDL approach involves generics and that's a great approach, but complicated.  The similitude approach is to let any link carry any number of values at once by using vectors.

We allow vectors to nest, so that complex busses can be represented too.  For example, a vector $[a,d,c]$ might represent the value of a bus where $c$, $d$, and $a$ are vectors representing control values, a data value, and an address.

## Error values

Any instantaneous value that contains an $E$ anywhere in it is an error value.  Each $E$ value has zero on more messages associated with it.

## Operations on instantaneous values

Length: $\#x$ is the length of $x$.  This applies only to vectors.

Catenation: Vectors can be catenated to make a new value whose length is the sum of the operands. For example

* $[H] \smallfrown [L] = [H,L]$
* $[U]  \smallfrown [] = [X]$
* $[H,L] \smallfrown [L,L,H]=[H,L,L,L,H)]$

Index: $x(i)$ where $i$ is an integer. This is defined when $x$ is a vector and $0\le 0 < \#x$. When the indexing is not defined, the result is $E$.

Substring: $x(i,..j)$, where $i$ and $j$ are integers. This is defined when $x$ is a vector and every $k$ such that $i \le i < j$ is such that $0 \le k < #x$. This is the value made by forming a vector $[x(j-1), x(j-2), ... x(i)]$.  In particular when $i \ge j$, the result is the empty vector.  In the undefined cases, it is $E$.

[Note: When defined, the length of the result is $\max(j-i,0)$.]

##Lifting

Logical operations such as AND, OR, IMPLIES, and resolution, are defined on the scalars by a truth tables. These scalar operations are then lifted to instantaneous values as follows. Here $s$ is any scalar value and @ represents any scalar operation

* $s @ [v_n-1, ... , v_1, v_0] = [s] @ [v_n-1, ... , v_1, v_0]= [s @ v_n-1, ... , s @ v_1, s @ v_0]$
* $[v_{n-1}, ... , v_1, v_0] @ s = [v_{n-1}, ... , v_1, v_0] @ [s]  = [v_{n-1} @ s, ... , v_1 @ s, v_0 @ s]$
* $[v_{n-1}, ... , v_1, v_0] @ [w_{n-1}, ..., w_1, w_0) = [v_{n-1} @ w_{n-1}, ... , v_1 @ w_1, v_0 @ w_0)$
* $[v_m-1, ... , v1, v0] @ [w_n-1, ..., w1, w0] = [E]$ when $m\not=n$ and neither length is 1.

This lifting is recursive. For example $[H, L]\; AND\; [[H,L],[H,L]] = [[H,L],[L,L]]$.

##Represetations

Number representation. Given a nonnegative integer $n$ and a nonnegative length $k$, we can define a representation of $n$ as an instantaneous value by $repr(n, k)$ as follows

*   $repr(0, 0) = []$
*   $repr(0, 1) = [L]$
*   $repr(1, 1) = [H]$
*   $repr(n, k)$, when $k > 1$ and $0 \le n < 2^k$ is a tuple $x$ of length $k$ so that $x$ is the unsigned magnitude representation of $n$. For example $repr(6,3) = [H,H,L]$.

For negative integer $n$, $repr(n,k)$ gives the two's complement representation. In particular

* $repr(-1,1) = [H]$
* $repr(-n,k)$, when $k > 1$ and $0 < n \le 2^{k-1}$ is a tuple $x$ of length $k$ the two’s complement representation of $-n$. For example $repr(-2,3)$ is $[H,H,L]$.

In all other cases, $repr(n,k)$ is $[E]$.

# Time

A time is a nonnegative number from 0 to $2^{64}-1$.  Each unit of time represents a femtosecond.

# Signal values

A signal value is a function from time to the set of vector values. 

## Vectorization

If the result of an operation is a scalar, it can't be the value of a signal at any time, so  we sometimes need to convert the scalar to a vector of length 1.  For example the result of an operation might be $E$, but in this case, to add it to a signal, we need to convert it to $[E]$.

#
