<%@ page import="com.hizon.MenuItem"%>



<div
	class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'name', 'error')} required">
	<label for="name"> <g:message code="menuItem.name.label"
			default="Name" /> <span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="100" required=""
		value="${menuItemInstance?.name}" />
</div>

<div
	class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'description', 'error')} ">
	<label for="description"> <g:message
			code="menuItem.description.label" default="Description" />

	</label>
	<g:textField name="description" maxlength="250"
		value="${menuItemInstance?.description}" />
</div>

<div
	class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'status', 'error')} required">
	<label for="status"> <g:message code="menuItem.status.label"
			default="Status" /> <span class="required-indicator">*</span>
	</label>
	<g:select name="status"
		from="${menuItemInstance.constraints.status.inList}" required=""
		value="${menuItemInstance?.status}"
		valueMessagePrefix="menuItem.status" />
</div>

<div
	class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'image', 'error')} ">
	<g:if test="${menuItemInstance?.imageFileName == null}">
		<label for="image"> <g:message code="menuItem.image.label"
				default="Image" />
		</label>
		<input type="file" name="imageFilename" id="imageFilename" />
	</g:if>
	
</div>

<div
	class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'menuItem', 'error')} required">
	<label for="menuItem"> <g:message
			code="menuItem.menuItem.label" default="Menu Category" /> <span
		class="required-indicator">*</span>
	</label>
	<g:select id="menuItem" name="menuItem.id"
		from="${com.hizon.MenuCategory.list()}" optionKey="id" required=""
		value="${menuItemInstance?.menuCategory?.id}" class="many-to-one" />
</div>

<div
	class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'packageCategory', 'error')} ">
	<label for="packageCategory"> <g:message
			code="menuItem.packageCategory.label" default="Package Category" />

	</label>
	<g:textField name="packageCategory"
		value="${menuItemInstance?.packageCategory}" />
</div>

