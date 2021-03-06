
<%@ page import="com.hizon.MenuItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuItem.label', default: 'MenuItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-menuItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-menuItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list menuItem">
			
				<g:if test="${menuItemInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="menuItem.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${menuItemInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="menuItem.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${menuItemInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="menuItem.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${menuItemInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.image}">
				<li class="fieldcontain">
					<span id="image-label" class="property-label"><g:message code="menuItem.image.label" default="Image" /></span>
					
						<span class="property-value" aria-labelledby="image-label">
						<g:img dir="/uploaded-files" file="${menuItemInstance.imageFileName}" width="500"/>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.menuCategory}">
				<li class="fieldcontain">
					<span id="menuCategory-label" class="property-label"><g:message code="menuItem.menuCategory.label" default="Menu Category" /></span>
					
						<span class="property-value" aria-labelledby="menuCategory-label"><g:link controller="menuCategory" action="show" id="${menuItemInstance?.menuCategory?.id}">${menuItemInstance?.menuCategory?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuItemInstance?.packageCategory}">
				<li class="fieldcontain">
					<span id="packageCategory-label" class="property-label"><g:message code="menuItem.packageCategory.label" default="Package Category" /></span>
					
						<span class="property-value" aria-labelledby="packageCategory-label"><g:fieldValue bean="${menuItemInstance}" field="packageCategory"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:menuItemInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${menuItemInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
