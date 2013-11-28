package com.hizon



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.web.multipart.commons.CommonsMultipartFile

@Transactional(readOnly = true)
class MenuItemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MenuItem.list(params), model:[menuItemInstanceCount: MenuItem.count()]
    }

    def show(MenuItem menuItemInstance) {
        respond menuItemInstance
    }

    def create() {
        respond new MenuItem(params)
    }

    @Transactional
    def save(MenuItem menuItemInstance) {
        if (menuItemInstance == null) {
            notFound()
            return
        }

		// will move this to a service in God's perfect time ;)
		CommonsMultipartFile uploadedFile = request.getFile('imageFilename')

		if(!uploadedFile.empty){
			println "Filename: ${uploadedFile.originalFilename}"

			def webRootDir = servletContext.getRealPath("/")
			def directory = new File(webRootDir, "/uploaded-files")
			directory.mkdirs()
			uploadedFile.transferTo(new File(directory, uploadedFile.originalFilename))
			menuItemInstance.image = "${directory}/${uploadedFile.originalFilename}"
			menuItemInstance.imageFileName = uploadedFile.originalFilename
		}

		if (menuItemInstance.hasErrors()) {
			respond menuItemInstance.errors, view:'create'
			return
		}

		menuItemInstance.save flush:true


		if (!menuItemInstance.save(flush: true)) {
			render(view: "create", model: [menuItemInstance: menuItemInstance])
			return
		}
		
		redirect(action: "show", id: menuItemInstance.id)
    }

    def edit(MenuItem menuItemInstance) {
        respond menuItemInstance
    }

    @Transactional
    def update(MenuItem menuItemInstance) {
        if (menuItemInstance == null) {
            notFound()
            return
        }

        if (menuItemInstance.hasErrors()) {
            respond menuItemInstance.errors, view:'edit'
            return
        }

        menuItemInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'MenuItem.label', default: 'MenuItem'), menuItemInstance.id])
                redirect menuItemInstance
            }
            '*'{ respond menuItemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(MenuItem menuItemInstance) {

        if (menuItemInstance == null) {
            notFound()
            return
        }

        menuItemInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'MenuItem.label', default: 'MenuItem'), menuItemInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuItemInstance.label', default: 'MenuItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
