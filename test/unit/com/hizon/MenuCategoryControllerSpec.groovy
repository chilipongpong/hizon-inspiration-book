package com.hizon



import grails.test.mixin.*
import spock.lang.*

@TestFor(MenuCategoryController)
@Mock(MenuCategory)
class MenuCategoryControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.menuCategoryInstanceList
            model.menuCategoryInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.menuCategoryInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def menuCategory = new MenuCategory()
            menuCategory.validate()
            controller.save(menuCategory)

        then:"The create view is rendered again with the correct model"
            model.menuCategoryInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            menuCategory = new MenuCategory(params)

            controller.save(menuCategory)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/menuCategory/show/1'
            controller.flash.message != null
            MenuCategory.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def menuCategory = new MenuCategory(params)
            controller.show(menuCategory)

        then:"A model is populated containing the domain instance"
            model.menuCategoryInstance == menuCategory
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def menuCategory = new MenuCategory(params)
            controller.edit(menuCategory)

        then:"A model is populated containing the domain instance"
            model.menuCategoryInstance == menuCategory
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            status == 404

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def menuCategory = new MenuCategory()
            menuCategory.validate()
            controller.update(menuCategory)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.menuCategoryInstance == menuCategory

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            menuCategory = new MenuCategory(params).save(flush: true)
            controller.update(menuCategory)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/menuCategory/show/$menuCategory.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.delete(null)

        then:"A 404 is returned"
            status == 404

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def menuCategory = new MenuCategory(params).save(flush: true)

        then:"It exists"
            MenuCategory.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(menuCategory)

        then:"The instance is deleted"
            MenuCategory.count() == 0
            response.redirectedUrl == '/menuCategory/index'
            flash.message != null
    }
}
