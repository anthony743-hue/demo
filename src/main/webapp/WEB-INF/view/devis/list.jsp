<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Document</title>
            <link rel="stylesheet" href="<c:url value='/assets/bootstrap/css/bootstrap.min.css' />">
        </head>

        <body>
            <!-- 
    Afficher la liste des devis avec un bouton (Voir plus pour pouvoir regarder la liste des devis_details dans une autre page)
    -->
            <table>
                <thead>
                    <th>Id</th>
                    <th>Date de Creation</th>
                    <th>Observation</th>
                </thead>
                <tbody>
                    <c:if test="${not empty liste_devis}">
                        <c:forEach items="${liste_devis}" var="item">
                            <td>{item.id}</td>
                            <td>{item.createAt}</td>
                            <td>{item.observation}</td>       
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </body>

        </html>