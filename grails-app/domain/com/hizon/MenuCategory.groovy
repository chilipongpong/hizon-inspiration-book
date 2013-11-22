package com.hizon

class MenuCategory {

	String name
	String description
	String status
	
    static constraints = {
		name(blank:false, unique:true, nullable:false)
		description(blank:true, nullable:true)
		status(inList:['Active', 'Inactive'], blank:false)
    }
	
	static searchable = true
}
