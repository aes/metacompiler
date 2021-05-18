# Meta-compiler

This is a descent into the rabbit hole suggested by this excellent (if dated)
[Meta-Compiler workshop](http://www.bayfronttechnologies.com/mc_workshop.html).

## Testing

There is a round-trip test to check that it really is a meta-compiler and a
second trip round-trip test to see if it produces a meta-compiler.

If it isn't a meta-compiler, but produces one, well, continue with that then.

## Hints

To swap in new code

    ./meta.g > m2.asm && mv m2.asm meta.asm

If you have `git-test`, configure it like this:

    git config test.verify "python3 -m unittest discover tests"
