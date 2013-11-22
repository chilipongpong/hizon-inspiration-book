
<%@ page import="com.hizon.MenuCategory" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuCategory.label', default: 'MenuCategory')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-menuCategory" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-menuCategory" class="content scaffold-list" role="main">
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
					
						<g:sortableColumn property="name" title="${message(code: 'menuCategory.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'menuCategory.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'menuCategory.status.label', default: 'Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${menuCategoryInstanceList}" status="i" var="menuCategoryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${menuCategoryInstance.id}">${fieldValue(bean: menuCategoryInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: menuCategoryInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: menuCategoryInstance, field: "status")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${menuCategoryInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
