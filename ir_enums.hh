
#ifndef IR_ENUMS_HH
#define IR_ENUMS_HH
enum IR_OPERATION_TYPE    {IR_OP_CONSTANT, IR_OP_VARIABLE, IR_OP_ARRAY_VARIABLE,
                           IR_OP_PLUS, IR_OP_MINUS, IR_OP_MULTIPLY, IR_OP_DIVIDE,
                           IR_OP_POSITIVE, IR_OP_NEGATIVE, IR_OP_NEQ,
                           IR_OP_MIN, IR_OP_MAX,IR_OP_EQ, IR_OP_LE, IR_OP_GE,
                           IR_OP_ASSIGNMENT, IR_OP_PLUS_ASSIGNMENT, IR_OP_CCAST, 
                           IR_OP_NULL, IR_OP_MOD, IR_OP_UNKNOWN};
enum IR_CONTROL_TYPE      {IR_CONTROL_LOOP, IR_CONTROL_IF, IR_CONTROL_WHILE, IR_CONTROL_BLOCK};
enum IR_CONSTANT_TYPE     {IR_CONSTANT_INT, IR_CONSTANT_FLOAT, IR_CONSTANT_DOUBLE,
                           IR_CONSTANT_UNKNOWN};

enum IR_CONDITION_TYPE    {IR_COND_LT, IR_COND_LE,
                           IR_COND_GT, IR_COND_GE,
                           IR_COND_EQ, IR_COND_NE,
                           IR_COND_UNKNOWN};
enum IR_ARRAY_LAYOUT_TYPE {IR_ARRAY_LAYOUT_ROW_MAJOR,
                           IR_ARRAY_LAYOUT_COLUMN_MAJOR,
                           IR_ARRAY_LAYOUT_SPACE_FILLING};
#endif
