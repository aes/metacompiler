# Meta-compiler

This is a descent into the rabbit hole suggested by this excellent (if dated)
[Meta-Compiler workshop](http://www.bayfronttechnologies.com/mc_workshop.html).

## Running it

The grammar file has a shebang that invokes `meta.py`, which has a  shebang
that invokes python3, which in turn is (normally) interpreted by a dynamic
linker.

    ./meta.g

### AEXP - Arithmetic expression grammar / compiler / machine

    ./aexp/aexp.g > aexp/aexp.asm
    # actually runs ./meta.py meta.asm aexp.g

    ./aexp/case1.aexp > aexp/case1.ae
    # actually runs ./meta.py aexp/aexp.asm aexp/case1.aexp

    ./aexp/case1.ae
    # actually runs ./aexp/aexp.py aexp/case1.ae


## Testing

There is a round-trip test to check that it really is a meta-compiler,
second trip round-trip test to see if it produces a meta-compiler and even
a third trip round-trip test to see if a fixed point is reached then.
(This happens if changing an opcode emitted in the definition. The first
step makes code that emits the new, the second step emits it, as does the
third. This makes the third result like the second.)

If it isn't a meta-compiler, but produces one, well, continue with that then.

## Hints

To swap in new code

    ./meta.g > m2.asm && mv m2.asm meta.asm

If you have `git-test`, configure it like this:

    git config test.verify "python3 -m unittest discover tests"
