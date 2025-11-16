# Week 2 Lab: System Verilog

## Make Note
**Exhaustively test all possible inputs**
* Pros: test design for all poissble inputs
* Cons: does not work for larger input sizes

**Sample some possible initial values for 100 cycles**
* Pros: faster than exhaustive testing for larger input sizes
* Cons: Not full coverage, might miss inputs that might cause failure

**Randomly test inputs for 100 cycles**
* Pros: high probability of discovering possible bugs
* Cons: No guarentee that corner cases are tested