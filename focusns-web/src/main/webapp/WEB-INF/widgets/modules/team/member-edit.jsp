<%@ page contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/widgets/widget.jsp"%>

<ui:widget styleClass="team-member-edit">
    <ui:widget-head>
        <ul class="nav nav-tabs">
            <li <c:if test="${empty param.tab}">class="active"</c:if> >
                <a href="<c:url value="/team/member;p=${project.code},m=edit" />">所有成员</a>
            </li>
            <li <c:if test="${param.tab eq 'link1'}">class="active"</c:if> >
                <a href="<c:url value="/team/member;p=${project.code},m=edit,tab=link1" />">关注</a>
            </li>
            <li <c:if test="${param.tab eq 'link2'}">class="active"</c:if> >
                <a href="<c:url value="/team/member;p=${project.code},m=edit,tab=link2" />">粉丝</a>
            </li>
        </ul>
    </ui:widget-head>
    <ui:widget-body>
        <c:choose>
            <c:when test="${empty param.tab}">
                <ul class="thumbnails">
                    <c:forEach items="${teamMemberPage.results}" var="teamMember">
                        <li class="span3">
                            <div class="thumbnail">
                                <div class="media">
                                    <a href="<c:url value="/profile;p=${teamMember.user.project.code}" />" class="pull-left">
                                        <tool:img-avatar projectUserId="${teamMember.user.id}" styleClass="media-object" width="80" height="80" />
                                    </a>
                                    <div class="media-body">
                                        <h3 class="media-heading">
                                            <a href="<c:url value="/profile;p=${teamMember.user.project.code}" />">
                                                    ${teamMember.user.nickname}
                                            </a>
                                                <%--<span class="pull-right badge badge-important">已关注</span>--%>
                                        </h3>
                                        <p>${teamMember.user.project.description}</p>
                                    </div>
                                    <c:if test="${teamMember.user.id != project.createdById && teamMember.user.id != projectUser.id}">
                                        <div class="pull-right btn-group dropup">
                                            <a class="btn btn-small dropdown-toggle" data-toggle="dropdown" href="#">
                                                加为好友
                                                <span class="caret"></span>
                                            </a>
                                            <ul class="dropdown-menu">
                                                <c:choose>
                                                    <c:when test="${empty projectRoles}">
                                                        <li>
                                                            <a href="<c:url value="/team/role;p=${project.code},m=edit" />">暂无好友分组，现在就来添加...</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${projectRoles}" var="projectRole">
                                                            <li>
                                                                <c:set var="actionId" value="member${teamMember.user.id}role${projectRole.id}"/>
                                                                <a href="#" onclick="javascript:document.getElementById('${actionId}').submit()">${projectRole.label}</a>
                                                                <form id="${actionId}" style="display: none" method="post" action="<widget:actionUrl value="/team/member-create" />">
                                                                    <input type="hidden" name="projectId" value="${project.id}" />
                                                                    <input type="hidden" name="userId" value="${teamMember.user.id}" />
                                                                    <input type="hidden" name="roleId" value="${projectRole.id}" />
                                                                    <input type="hidden" name="createdById" value="${projectUser.id}" />
                                                                    <input type="hidden" name="modifiedById" value="${projectUser.id}" />
                                                                </form>
                                                            </li>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>

                <c:url var="pageLink" value="/team/member;p=${project.code},m=edit" />
                <tool:pagination page="${teamMemberPage}" pageLink="${pageLink}" />
            </c:when>
            <c:when test="${param.tab eq 'link1'}">
                <c:choose>
                    <c:when test="${empty linkPage.results}">
                        <div class="alert alert-info">
                            当前还没有关注...
                        </div>
                    </c:when>
                    <c:otherwise>
                        <ul class="thumbnails">
                            <c:forEach items="${linkPage.results}" var="projectLink">
                                <li class="span3">
                                    <div class="thumbnail">
                                        <tool:img-avatar projectUserId="${projectLink.toProject.createdById}" width="80" height="80" />
                                        <h3>${projectLink.toProject.title}</h3>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:when test="${param.tab eq 'link2'}">
                <c:choose>
                    <c:when test="${empty reversedLinkPage.results}">
                        <div class="alert alert-info">
                            当前还没有粉丝...
                        </div>
                    </c:when>
                    <c:otherwise>
                        <ul class="thumbnails">
                            <c:forEach items="${reversedLinkPage.results}" var="projectLink">
                                <li class="span3">
                                    <div class="thumbnail">
                                        <tool:img-avatar projectUserId="${projectLink.fromProject.createdById}" width="80" height="80" />
                                        <h3>${projectLink.fromProject.title}</h3>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </c:when>
        </c:choose>
    </ui:widget-body>
</ui:widget>

