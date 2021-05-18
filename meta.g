#!./meta.py meta.asm
.SYNTAX PROGRAM

PROGRAM
  = '.SYNTAX' .ID .OUT ( .TB 'ADR ' * .NL )
    $ ST
    '.END' .OUT ( .TB 'END' .NL )
  ;

ST
  = .ID .OUT ( * .NL ) '=' EX1 ';' .OUT ( .TB 'R' .NL )
  ;

EX1
  = EX2 $ ( '/' .OUT ( .TB 'BT ' # .NL ) EX2 ) .OUT ( # .NL )
  ;

EX2
  = ( EX3 .OUT ( .TB 'BF ' # .NL ) / OUTPUT )
    $ ( EX3 .OUT ( .TB 'BE' .NL ) / OUTPUT )
    .OUT ( # .NL )
  ;

EX3
  = .ID       .OUT ( .TB 'CLL ' * .NL )
  / .STRING   .OUT ( .TB 'TST ' * .NL )
  / '.ID'     .OUT ( .TB 'ID' .NL )
  / '.NUMBER' .OUT ( .TB 'NUM' .NL )
  / '.STRING' .OUT ( .TB 'SR' .NL )
  / '(' EX1 ')'
  / '.EMPTY'  .OUT ( .TB 'SET' .NL )
  / '$'
    .OUT ( # .NL )
    EX3
    .OUT ( .TB 'BT ' # .NL )
    .OUT ( .TB 'SET' .NL )
  ;

OUTPUT
  = '.OUT' '(' $ OUT1 ')'
  / '{' $ OUT1 '}'
  ;

OUT1
  = '*'     .OUT ( .TB 'CI' .NL )
  / .STRING .OUT ( .TB 'CL ' * .NL )
  / '#'     .OUT ( .TB 'GN1' .NL )
  / '.NL'   .OUT ( .TB 'NL' .NL )
  / '.LB'   .OUT ( .TB 'LB' .NL )
  / '.TB'   .OUT ( .TB 'TB' .NL )
  / '.LM+'  .OUT ( .TB 'LMI' .NL )
  / '.LM-'  .OUT ( .TB 'LMD' .NL )
  ;

.END
