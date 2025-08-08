#[test_only]
module hello_move::hello_move_tests;

use hello_move::calculator;
use sui::test_scenario;
use std::string;

// Test Addition function
#[test]
fun test_addition() {
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);
    
    // Test: 5 + 10 = 15
    calculator::Addition(5, 10, @0x1, ctx);
    
    test_scenario::next_tx(&mut scenario, @0x1);
    
    // Verify the result object was created and transferred
    let result = test_scenario::take_from_sender<calculator::Result>(&scenario);
    assert!(calculator::get_answer(&result) == 15, 0);
    assert!(calculator::get_operation(&result) == string::utf8(b"Addition"), 1);
    
    test_scenario::return_to_sender(&scenario, result);
    test_scenario::end(scenario);
}

// Test Subtraction function
#[test]
fun test_subtraction() {
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);
    
    // Test: 20 - 8 = 12
    calculator::Substraction(20, 8, @0x1, ctx);
    
    test_scenario::next_tx(&mut scenario, @0x1);
    
    let result = test_scenario::take_from_sender<calculator::Result>(&scenario);
    assert!(calculator::get_answer(&result) == 12, 0);
    assert!(calculator::get_operation(&result) == string::utf8(b"Subtraction"), 1);
    
    test_scenario::return_to_sender(&scenario, result);
    test_scenario::end(scenario);
}

// Test Multiplication function
#[test]
fun test_multiplication() {
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);
    
    // Test: 6 * 7 = 42
    calculator::Multiplication(6, 7, @0x1, ctx);
    
    test_scenario::next_tx(&mut scenario, @0x1);
    
    let result = test_scenario::take_from_sender<calculator::Result>(&scenario);
    assert!(calculator::get_answer(&result) == 42, 0);
    assert!(calculator::get_operation(&result) == string::utf8(b"Multiplication"), 1);
    
    test_scenario::return_to_sender(&scenario, result);
    test_scenario::end(scenario);
}

// Test Division function
#[test]
fun test_division() {
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);
    
    // Test: 56 / 8 = 7
    calculator::Division(56, 8, @0x1, ctx);
    
    test_scenario::next_tx(&mut scenario, @0x1);
    
    let result = test_scenario::take_from_sender<calculator::Result>(&scenario);
    assert!(calculator::get_answer(&result) == 7, 0);
    assert!(calculator::get_operation(&result) == string::utf8(b"DIvision"), 1); // Note: keeping your typo for consistency
    
    test_scenario::return_to_sender(&scenario, result);
    test_scenario::end(scenario);
}

// Test Exponential function
#[test]
fun test_exponential() {
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);
    
    // Test: 2^3 = 8
    calculator::Exponential(2, 3, @0x1, ctx);
    
    test_scenario::next_tx(&mut scenario, @0x1);
    
    let result = test_scenario::take_from_sender<calculator::Result>(&scenario);
    assert!(calculator::get_answer(&result) == 8, 0);
    assert!(calculator::get_operation(&result) == string::utf8(b"Exponential"), 1);
    
    test_scenario::return_to_sender(&scenario, result);
    test_scenario::end(scenario);
}

// Test Exponential with exponent 0
#[test]
fun test_exponential_zero_exponent() {
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);
    
    // Test: 5^0 = 1 (any number to power 0 equals 1)
    calculator::Exponential(5, 0, @0x1, ctx);
    
    test_scenario::next_tx(&mut scenario, @0x1);
    
    let result = test_scenario::take_from_sender<calculator::Result>(&scenario);
    assert!(calculator::get_answer(&result) == 1, 0);
    assert!(calculator::get_operation(&result) == string::utf8(b"Exponential"), 1);
    
    test_scenario::return_to_sender(&scenario, result);
    test_scenario::end(scenario);
}

// Test Division by zero (should abort)
#[test]
#[expected_failure(arithmetic_error, location = hello_move::calculator)]
fun test_division_by_zero() {
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);
    
    // This should fail: division by zero
    calculator::Division(10, 0, @0x1, ctx);
    
    test_scenario::end(scenario);
}

// Test edge cases with maximum u8 values
#[test]
fun test_edge_cases() {
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);
    
    // Test: 255 + 0 = 255 (max u8 value)
    calculator::Addition(255, 0, @0x1, ctx);
    
    test_scenario::next_tx(&mut scenario, @0x1);
    
    let result = test_scenario::take_from_sender<calculator::Result>(&scenario);
    assert!(calculator::get_answer(&result) == 255, 0);
    
    test_scenario::return_to_sender(&scenario, result);
    test_scenario::end(scenario);
}
