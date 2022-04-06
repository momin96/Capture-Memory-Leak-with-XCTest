//
//  Capture_Memory_Leak_with_XCTestTests.swift
//  Capture Memory Leak with XCTestTests
//
//  Created by Nasir Ahmed Momin on 05/04/22.
//

import XCTest
@testable import Capture_Memory_Leak_with_XCTest

class Capture_Memory_Leak_with_XCTestTests: XCTestCase {
    
    /// holds refereces of instance of each type
    /// On deallocation of `viewModel.department` these types will be nil'ed out.
    private weak var weakDepartment: Department?
    private weak var weakEmployee: Employee?
    
    override func tearDown() {
        super.tearDown()
        assertMemoryLeakOnEmployee()
        assertMemoryLeakOnDepartment()
    }
    
    private func assertMemoryLeakOnEmployee() {
        /// Once `employee` instance is dealloacted then `weakEmployee` will also gets dealloacted &  below test will success
        XCTAssertNil(weakEmployee, "Employee Object is leaking")
    }
    
    private func assertMemoryLeakOnDepartment() {
        /// Once `department` instance is dealloacted then `weakDepartment` will also gets dealloacted & below test will success
        XCTAssertNil(weakDepartment, "Department Object is leaking")
    }
    
    func test_employeeExistsInDepartment() {
        let iOSDepartment = Department(1, name: "iOS")
        let abc = Employee(1, name: "ABC", department: iOSDepartment)
        
        let viewModel = DepartmentViewModel(iOSDepartment)
        viewModel.add(abc)
        
        // Entire memory leak magic happens here.
        // By end of this function, If proper object deallocation happens, it is expected that below instance(s) will be nil'lyfied
        weakEmployee = abc
        weakDepartment = iOSDepartment
        
        let employeeExist = iOSDepartment.employees.contains {
            abc.id == $0.id
        }
        
        XCTAssertTrue(employeeExist)
    }
}
