#!./meta.py meta.asm
.SYNTAX PROGRAM

PROGRAM
  = '.SYNTAX' .ID .OUT ( .LB .TB 'ADR ' * .NL )
    $ ST
    '.END' .OUT ( .LB .TB 'END' .NL )
  ;

ST
  = .ID .OUT ( .LB * .NL ) '=' EX1 ';' .OUT ( .LB .TB 'R' .NL )
  ;

EX1
  = EX2 $ ( '/' .OUT ( .LB .TB 'BT ' *1 .NL ) EX2 ) .OUT ( .LB # .NL )
  ;

EX2
  = ( EX3 .OUT ( .LB .TB 'BF ' *1 .NL ) / OUTPUT )
    $ ( EX3 .OUT ( .LB .TB 'BE' .NL ) / OUTPUT )
    .OUT ( .LB # .NL )
  ;

EX3
  = .ID       .OUT ( .LB .TB 'CLL ' * .NL )
  / .STRING   .OUT ( .LB .TB 'TST ' * .NL )
  / '.ID'     .OUT ( .LB .TB 'ID' .NL )
  / '.NUMBER' .OUT ( .LB .TB 'NUM' .NL )
  / '.STRING' .OUT ( .LB .TB 'SR' .NL )
  / '(' EX1 ')'
  / '.EMPTY'  .OUT ( .LB .TB 'SET' .NL )
  / '$'
    .OUT ( .LB # .NL )
    EX3
    .OUT ( .LB .TB 'BT ' *1 .NL )
    .OUT ( .LB .TB 'SET' .NL )
  ;

OUTPUT
  = '.OUT' '(' $ OUT1 ')'
  ;

OUT1
  = '*1'    .OUT ( .LB .TB 'GN1' .NL )
  / '*2'    .OUT ( .LB .TB 'GN2' .NL )
  / '*'     .OUT ( .LB .TB 'CI' .NL )
  / .STRING .OUT ( .LB .TB 'CL ' * .NL )
  / '#'     .OUT ( .LB .TB 'GN1' .NL )
  / '.NL'   .OUT ( .LB .TB 'NL' .NL )
  / '.LB'   .OUT ( .LB .TB 'LB' .NL )
  / '.TB'   .OUT ( .LB .TB 'TB' .NL )
  / '.LM+'  .OUT ( .LB .TB 'LMI' .NL )
  / '.LM-'  .OUT ( .LB .TB 'LMD' .NL )
  ;

.END
