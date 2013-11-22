package com.hizon



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.compass.core.engine.SearchEngineQueryParseException

@Transactional(readOnly = true)
class MenuCategoryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	static String WILDCARD = "*"
	def searchableService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MenuCategory.list(params), model:[menuCategoryInstanceCount: MenuCategory.count()]
    }

    def show(MenuCategory menuCategoryInstance) {
        respond menuCategoryInstance
    }

    def create() {
        respond new MenuCategory(params)
    }

    @Transactional
    def save(MenuCategory menuCategoryInstance) {
        if (menuCategoryInstance == null) {
            notFound()
            return
        }

        if (menuCategoryInstance.hasErrors()) {
            respond menuCategoryInstance.errors, view:'create'
            return
        }

        menuCategoryInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'menuCategoryInstance.label', default: 'MenuCategory'), menuCategoryInstance.id])
                redirect menuCategoryInstance
            }
            '*' { respond menuCategoryInstance, [status: CREATED] }
        }
    }

    def edit(MenuCategory menuCategoryInstance) {
        respond menuCategoryInstance
    }

    @Transactional
    def update(MenuCategory menuCategoryInstance) {
        if (menuCategoryInstance == null) {
            notFound()
            return
        }

        if (menuCategoryInstance.hasErrors()) {
            respond menuCategoryInstance.errors, view:'edit'
            return
        }

        menuCategoryInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'MenuCategory.label', default: 'MenuCategory'), menuCategoryInstance.id])
                redirect menuCategoryInstance
            }
            '*'{ respond menuCategoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(MenuCategory menuCategoryInstance) {

        if (menuCategoryInstance == null) {
            notFound()
            return
        }

        menuCategoryInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'MenuCategory.label', default: 'MenuCategory'), menuCategoryInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuCategoryInstance.label', default: 'MenuCategory'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	def search(){
		if (!params.q?.trim()) {
			return [:]
		}
		try {
			String searchTerm = WILDCARD+params.q+WILDCARD
			return [menuCategoryInstanceList: MenuCategory.search(searchTerm, params)]
		} catch (SearchEngineQueryParseException ex) {
			return [parseException: true]
		}
	}
	
	def indexAll = {
		Thread.start {
			searchableService.index()
		}
		render("bulk index started in a background thread")
	}

	/**
	 * Perform a bulk index of every searchable object in the database
	 */
	def unindexAll = {
		searchableService.unindex()
		render("unindexAll done")
	}
}
