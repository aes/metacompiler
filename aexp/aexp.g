#!./meta.py meta.asm
.SYNTAX AEXP

AEXP
  =                    { '#!./aexp/aexp.py' .NL }
    AS $AS
  ;

AS
  = .ID                { .TB 'lea ' * .NL }
    ':=' EX1           { .TB 'sto ' .NL }
    ';'
  ;

EX1
  = EX2 $(
        '+' EX2        { .TB 'add' .NL }
      / '-' EX2        { .TB 'sub' .NL }
    )
  ;

EX2
  = EX3 $(
        '*' EX3        { .TB 'mul' .NL }
      / '/' EX3        { .TB 'div' .NL }
    )
  ;
EX3
  = EX4 $('^' EX3      { .TB 'exp' .NL } )
  ;

EX4
  = '+' EX5
  / '-' EX5            { .TB 'neg' .NL }
  / EX5
  ;

EX5
  = .ID                { .TB 'lod ' * .NL }
  / .NUMBER            { .TB 'psh ' * .NL }
  / '(' EX1 ')'
  ;

.END
