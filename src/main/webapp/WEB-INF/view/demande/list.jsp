<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .actions {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }
</style>
<div class="container p-4">
    <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3">
        <div>
            <h1>Liste des demandes</h1>
        </div>
        <a class="btn btn-light text-success fw-semibold" href="<c:url value='/demande/add' />">
            Ajouter une demande
        </a>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-bordered align-middle mb-0">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th class="px-5" scope="col">Nom du client</th>
                        <th scope="col">Statut</th>
                        <th scope="col">Localisation</th>
                        <th class=" text-center text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listDemande}">
                            <c:forEach items="${listDemande}" var="item">
                                <tr>
                                    <td class=" ">${item.id}</td>
                                    <td class="  fw-semibold">${item.client.nom}</td>
                                    <td class=" ">
                                        <span class="">${item.status.designation}</span>
                                    </td>
                                    <td class=" ">${item.localisation}</td>
                                    <td class="  text-end">
                                        <div class="actions justify-content-end">
                                            <a class="btn btn-sm btn-outline-primary"
                                                href="<c:url value='/demande/update?id=${item.id}' />">
                                                Modifier
                                            </a>
                                            <a class="btn btn-sm btn-outline-danger"
                                                href="<c:url value='/demande/remove?id=${item.id}' />">
                                                Supprimer
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5"><p class="mb-3 text-center">Aucune demande n'est disponible pour le moment.</p></td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>