//
//  DepartmentViewModel.swift
//  Capture Memory Leak with XCTest
//
//  Created by Nasir Ahmed Momin on 05/04/22.
//

import Foundation

class DepartmentViewModel {
    
    var department: Department
    
    init(_ department: Department) {
        self.department = department
    }
    
    func add(_ employee: Employee) {
        department.employees.append(employee)
    }
}

class Employee {
    var id: Int
    var name: String
    var department: Department
    
    init(_ id: Int, name: String, department: Department) {
        self.id = id
        self.name = name
        self.department = department
    }
}

class Department {
    var id: Int
    var name: String
    var employees = [Employee]()
    
    init(_  id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
