<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <div class="container">
            <div class="row d-fkex justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="mb-3 text-bold">StatusDemande</div>
                    <div class="mb-3">
                        <label for="demandeInput" class="form-label fw-semibold">Demande</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control" id="demandeInput" name="reference"
                                placeholder="Référence de la demande...">
                        </div>
                    </div>
                    <form id="formTemp">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="date" class="form-label fw-semibold">Date</label>
                                <input type="datetime-local" name="createAt" class="form-control" id="daty">
                            </div>
                            <div class="col-md-6">
                                <label for="lieu" class="form-label fw-semibold">Observation</label>
                                <input type="text" name="obs" class="form-control" id="obs"
                                    placeholder="****">
                            </div>
                            <div class="col-md-6">
                                <label for="type" class="form-label fw-semibold">Statut</label>
                                <select name="status" id="status" class="form-select">
                                    <c:if test="${not empty listeStatus}">
                                        <c:forEach items="${listeStatus}" var="item">
                                            <option value="${item.id}">${item.designation}</option>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Modifier le Status Demande</button>
                    </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        