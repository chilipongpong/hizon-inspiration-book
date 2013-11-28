package com.hizon

class MenuCategory {

	String name
	String description
	String status
	
    static constraints = {
		name blank:false, unique:true, nullable:false, size: 1..100
		description blank:true, nullable:true, size: 0..250
		status inList:['Active', 'Inactive'], blank:false
    }
	
	static searchable = true
}
