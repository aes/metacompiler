#!./meta.py meta.asm
.SYNTAX PROGRAM

PROGRAM
  = '.SYNTAX' .ID .OUT ( .LB .TB 'ADR ' * )
    $ ST
    '.END' .OUT ( .LB .TB 'END' )
  ;

ST
  = .ID .OUT ( .LB * ) '=' EX1 ';' .OUT ( .LB .TB 'R' )
  ;

EX1
  = EX2 $ ( '/' .OUT ( .LB .TB 'BT ' *1 ) EX2 ) .OUT ( .LB # )
  ;

EX2
  = ( EX3 .OUT ( .LB .TB 'BF ' *1 ) / OUTPUT )
    $ ( EX3 .OUT ( .LB .TB 'BE' ) / OUTPUT )
    .OUT ( .LB # )
  ;

EX3
  = .ID       .OUT ( .LB .TB 'CLL ' * )
  / .STRING   .OUT ( .LB .TB 'TST ' * )
  / '.ID'     .OUT ( .LB .TB 'ID' )
  / '.NUMBER' .OUT ( .LB .TB 'NUM' )
  / '.STRING' .OUT ( .LB .TB 'SR' )
  / '(' EX1 ')'
  / '.EMPTY'  .OUT ( .LB .TB 'SET' )
  / '$' .OUT ( .LB # ) EX3 .OUT ( .LB .TB 'BT ' *1 ) .OUT ( .LB .TB 'SET' )
  ;

OUTPUT
  = (
      '.OUT' '(' $ OUT1 ')'
    )
    .OUT ( .LB .TB 'OUT' )
  ;

OUT1
  = '*1'    .OUT ( .LB .TB 'GN1' )
  / '*2'    .OUT ( .LB .TB 'GN2' )
  / '*'     .OUT ( .LB .TB 'CI' )
  / .STRING .OUT ( .LB .TB 'CL ' * )
  / '#'     .OUT ( .LB .TB 'GN1' )
  / '.NL'   .OUT ( .LB .TB 'NL' )
  / '.LB'   .OUT ( .LB .TB 'LB' )
  / '.TB'   .OUT ( .LB .TB 'TB' )
  / '.LM+'  .OUT ( .LB .TB 'LMI' )
  / '.LM-'  .OUT ( .LB .TB 'LMD' )
  ;

.END
