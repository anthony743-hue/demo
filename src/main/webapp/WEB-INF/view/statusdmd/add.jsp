<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <!-- Messages flash globaux (succès/erreur technique) -->
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${successMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="card">
                <div class="card-body">
                    <form id="formAddStatusDmd" modelAttribute="statusDemande"
                               action="<c:url value='/statusdmd/add' />" method="post">
                        <div class="row g-3">
                            <!-- Champ demande -->
                            <div class="col-12">
                                <label for="ref" class="form-label fw-semibold">Référence de la demande</label>
                                <select name="demande.id" id="ref" class="form-select">
                                    <option value="">Choisir une demande...</option>
                                    <c:forEach items="${listeDemande}" var="item">
                                        <option value="${item.id}"
                                            ${not empty statusDemande and statusDemande.demande.id eq item.id ? 'selected' : ''}>
                                            ${item.reference}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Champ date -->
                            <div class="col-md-6">
                                <label for="date" class="form-label fw-semibold">Date</label>
                                <input type="datetime-local" name="daty" class="form-control" id="date"
                                       value="${not empty statusDemande and statusDemande.daty != null ? statusDemande.daty : ''}" />
                            </div>

                            <!-- Champ observation -->
                            <div class="col-md-6">
                                <label for="lieu" class="form-label fw-semibold">Observation</label>
                                <input type="text" name="observation" class="form-control" id="lieu"
                                       value="${not empty statusDemande and statusDemande.observation != null ? statusDemande.observation : ''}" />
                            </div>

                            <!-- Champ statut -->
                            <div class="col-md-6">
                                <label for="status" class="form-label fw-semibold">Statut</label>
                                <select name="status.id" id="status" class="form-select">
                                    <c:forEach items="${listeStatus}" var="item">
                                        <option value="${item.id}"
                                            ${not empty statusDemande and statusDemande.status.id eq item.id ? 'selected' : ''}>
                                            ${item.designation}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-12">
                                <button type="submit" class="btn btn-primary w-100">Enregistrer le Statut Demande</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>