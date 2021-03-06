<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>

<jcr:nodeProperty node="${currentNode}" name="maxNews" var="maxNews"/>
<jcr:nodeProperty node="${currentNode}" name="filter" var="filter"/>
<c:choose>
<c:when test="${empty filter.string}">
    <c:set var="lastNewsStatement" value="select * from [jnt:news] as news where ISDESCENDANTNODE(news,'${currentNode.resolveSite.path}') order by news.[date] desc"/>
</c:when>
<c:otherwise>
    <c:set var="lastNewsStatement" value="select * from [jnt:news] as news where ISDESCENDANTNODE(news,'${currentNode.resolveSite.path}') and news.[j:defaultCategory]='${filter.string}' order by news.[date] desc"/>
</c:otherwise>
</c:choose>
<query:definition var="listQuery" statement="${lastNewsStatement}" limit="${maxNews.long}"  />

<c:set target="${moduleMap}" property="editable" value="false" />
<c:set target="${moduleMap}" property="emptyListMessage"><fmt:message key="label.noNewsFound"/></c:set>
<c:set target="${moduleMap}" property="listQuery" value="${listQuery}" />
<c:set target="${moduleMap}" property="subNodesView" value="${currentNode.properties['j:subNodesView'].string}" />
