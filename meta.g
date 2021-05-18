#!./meta.py meta.asm
.SYNTAX PROGRAM

PROGRAM
  = '.SYNTAX' .ID { .TB 'ADR ' * .NL }
    $ ST
    '.END' { .TB 'END' .NL }
  ;

ST
  = .ID { * .NL } '=' EX1 ';' { .TB 'R' .NL }
  ;

EX1
  = EX2 $ ( '/' { .TB 'BT L' # .NL } EX2 ) { 'L' # .NL }
  ;

EX2
  = ( EX3 { .TB 'BF L' # .NL } / OUTPUT )
    $ ( EX3 { .TB 'BE' .NL } / OUTPUT )
    { 'L' # .NL }
  ;

EX3
  = .ID       { .TB 'CLL ' * .NL }
  / .STRING   { .TB 'TST ' * .NL }
  / '.ID'     { .TB 'ID' .NL }
  / '.NUMBER' { .TB 'NUM' .NL }
  / '.STRING' { .TB 'SR' .NL }
  / '(' EX1 ')'
  / '.EMPTY'  { .TB 'SET' .NL }
  / '$'
    { 'L' # .NL }
    EX3
    { .TB 'BT L' # .NL }
    { .TB 'SET' .NL }
  ;

OUTPUT
  = '{' $ OUT1 '}'
  ;

OUT1
  = '*'     { .TB 'CI' .NL }
  / .STRING { .TB 'CL ' * .NL }
  / '#'     { .TB 'GN' .NL }
  / '.NL'   { .TB 'NL' .NL }
  / '.TB'   { .TB 'TB' .NL }
  / '.LM+'  { .TB 'LMI' .NL }
  / '.LM-'  { .TB 'LMD' .NL }
  ;

.END
