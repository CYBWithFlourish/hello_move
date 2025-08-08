module hello_move::calculator;
use std::string::String;

public struct Result has key{
    id: UID,
    answer: u8,
    operation: String
}

// Getter functions for testing
public fun get_answer(result: &Result): u8 {
    result.answer
}

public fun get_operation(result: &Result): String {
    result.operation
}

public fun Addition(num1: u8, num2: u16, addr: address, ctx: &mut TxContext){
    let result: u8 = num1 + (num2 as u8);
    let res = Result{
        id: object::new(ctx),
        answer: result,
        operation: b"Addition".to_string()
    };
    transfer::transfer(res, addr);
}

public fun Substraction(num1: u8, num2: u16, addr: address, ctx: &mut TxContext){
    let result: u8 = num1 - (num2 as u8);
    let res = Result{
        id: object::new(ctx),
        answer: result,
        operation: b"Subtraction".to_string()
    };
    transfer::transfer(res, addr); 
}

public fun Multiplication(num1: u8, num2: u16, addr: address, ctx: &mut TxContext){
    let result: u8 = num1 * (num2 as u8);
    let res = Result{
        id: object::new(ctx),
        answer: result,
        operation: b"Multiplication".to_string()
    };
    transfer::transfer(res, addr);
}

public fun Division(num1: u8, num2: u16, addr: address, ctx: &mut TxContext){
    let result: u8 = num1 / (num2 as u8);
    let res = Result{
        id: object::new(ctx),
        answer: result,
        operation: b"DIvision".to_string()
    };
    transfer::transfer(res, addr);
}

public fun Exponential(num1: u8, num2: u16, addr: address, ctx: &mut TxContext){
    let base = num1;
    let exponent = (num2 as u8);
    let mut result: u8 = 1;
    
    // Handle special case: anything to the power of 0 is 1
    if (exponent == 0) {
        result = 1;
    } else {
        let mut i = 0;
        while (i < exponent) {
            result = result * base;
            i = i + 1;
        };
    };
    
    let res = Result{
        id: object::new(ctx),
        answer: result,
        operation: b"Exponential".to_string()
    };
    transfer::transfer(res, addr);
}