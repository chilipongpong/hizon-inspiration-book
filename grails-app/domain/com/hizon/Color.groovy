package com.hizon

class Color {

	String name;
	String description;
	//TODO: decide how to store color if hex or image or whatnot
	
    static constraints = {
		name(blank:false, unique:true, nullable:false)
		description(blank:true, nullable:true)
    }
	
	static searchable = true
}
