#!./meta.py meta.asm
.SYNTAX PROGRAM

PROGRAM
  = '.SYNTAX' .ID .OUT ( 'ADR ' * )
    $ ST
    '.END' .OUT ( 'END' )
  ;

ST
  = .ID .OUT ( .LB * ) '=' EX1 ';' .OUT ( 'R' )
  ;

EX1
  = EX2 $ ( '/' .OUT ( 'BT ' *1 ) EX2 ) .OUT ( .LB # )
  ;

EX2
  = ( EX3 .OUT ( 'BF ' *1 ) / OUTPUT )
    $ ( EX3 .OUT ( 'BE' ) / OUTPUT )
    .OUT ( .LB # )
  ;

EX3
  = .ID       .OUT ( 'CLL ' * )
  / .STRING   .OUT ( 'TST ' * )
  / '.ID'     .OUT ( 'ID' )
  / '.NUMBER' .OUT ( 'NUM' )
  / '.STRING' .OUT ( 'SR' )
  / '(' EX1 ')'
  / '.EMPTY'  .OUT ( 'SET' )
  / '$' .OUT ( .LB # ) EX3 .OUT ( 'BT ' *1 ) .OUT ( 'SET' )
  ;

OUTPUT
  = (
        '.OUT' '(' $ OUT1 ')'
    )
    .OUT ( 'OUT' )
  ;

OUT1
  = '*1'    .OUT ( 'GN1' )
  / '*2'    .OUT ( 'GN2' )
  / '*'     .OUT ( 'CI' )
  / .STRING .OUT ( 'CL ' * )
  / '#'     .OUT ( 'GN1' )
  / '.NL'   .OUT ( 'NL' )
  / '.LB'   .OUT ( 'LB' )
  / '.TB'   .OUT ( 'TB' )
  / '.LM+'  .OUT ( 'LMI' )
  / '.LM-'  .OUT ( 'LMD' )
  ;

.END
