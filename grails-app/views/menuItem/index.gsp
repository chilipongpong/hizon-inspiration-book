
<%@ page import="com.hizon.MenuItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuItem.label', default: 'MenuItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-menuItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-menuItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:form action="search" method="get">
			<g:textField name="q" value="${params.q}" />
			<g:submitButton name="search" />
		</g:form>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'menuItem.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'menuItem.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'menuItem.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="image" title="${message(code: 'menuItem.image.label', default: 'Image')}" />
					
						<th><g:message code="menuItem.menuItem.label" default="Menu Category" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${menuItemInstanceList}" status="i" var="menuItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${menuItemInstance.id}">${fieldValue(bean: menuItemInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: menuItemInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: menuItemInstance, field: "status")}</td>
					
						<td><g:img dir="/uploaded-files" file="${menuItemInstance.imageFileName}" width="150"/></td>
					
						<td>${fieldValue(bean: menuItemInstance, field: "menuItem")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${menuItemInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
