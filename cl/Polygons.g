grammar Polygons;

root: expr+ EOF;

expr: variable | instruction;

variable: ID ':=' operation
        //| ID ':=' coords
        ;

operation: '(' operation ')'
        // | EXC NUM
        | PAD operation
        | operation MUL operation
        | operation MES operation
        | coords
        | ID
        //| R
        //| NUM
        ;

instruction:  printPol
            | area
            | perimeter
            | vertices
            | centroid
            | color
            | inside
            | equal
            | draw
            ;

// coords: '[' ( (NUM | R) (NUM | R) )* ']';
coords: '[' ( (NUM | R) (NUM | R) )* ']';
colorRGB: '{' NUM NUM NUM '}';
img: '"'ID'.png"';
text: '"'(ID | G)+'"';
polygons: ( operation ) (',' operation)*;

printPol: 'print'(operation | text);
area: 'area' operation;
perimeter: 'perimeter' operation;
vertices: 'vertices' operation;
centroid: 'centroid' operation;
color: 'color' operation ',' colorRGB;
inside: 'inside' operation ',' operation;
equal: 'equal' operation ',' operation;
draw: 'draw' img ',' polygons;

NUM: [0-9]+;
ID : [a-zA-Z]+('_')?[a-zA-Z0-9]*;
R: [0-9]* '.' [0-9]+;
G: ('-')+;

MUL: '*';   // represents the intersection of two polygons.
MES: '+';   // represents the convex union of two polygons.
PAD: '#';   // is the unary operator that returns the bounding box of a polygon
EXC: '!';   // returns a convex polygon made with n points drawn at random in the unit square ([0,1]²).

LINE_COMMENT: '//' ~[\r\n]* -> skip;
WS : [ \t\r\n]+ -> skip;    // skip spaces, tabs, newlines