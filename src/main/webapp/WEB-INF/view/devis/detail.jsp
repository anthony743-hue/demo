<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <style>
            /* Reprise exacte du style des demandes */
            .actions {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
                justify-content: flex-end;
            }

            .table-card {
                overflow: hidden;
                border: 1px solid #black;
            }

            .table-bordered th,
            .table-bordered td {
                border-color: #e9ecef;
            }

            thead th {
                background-color: #f8f9fa;
                font-weight: 600;
                color: #1e2a3e;
                border-bottom-width: 1px;
            }

            .btn-light {
                background-color: #f8f9fa;
                border-color: #dee2e6;
            }

            .btn-light:hover {
                background-color: #e9ecef;
            }

            .btn-sm {
                border-radius: 0.375rem;
            }

            .text-end {
                text-align: right;
            }

            .container.p-4 {
                max-width: 1400px;
            }
        </style>
        <div class="container p-4">
            <div class="row">
                <div class="col-6">
                    <div
                        class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3 mb-4">
                        <div>
                            <h1>Liste des details</h1>
                        </div>
                        <a class="btn btn-light text-primary fw-semibold" href="<c:url value='/devis/list' />">
                            Retour
                        </a>
                    </div>
                </div>
                <div class="col-12">
                    <div class="row">
                        <div class="col-6">
                            <div class="table-card">
                                <div class="table-responsive">
                                    <table class="table table-bordered align-middle mb-0">
                                        <thead>
                                            <tr>
                                                <th class="" scope="col">Libelle</th>
                                                <th scope="col">Quantite</th>
                                                <th class="text-center text-end" scope="col">PU</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${liste_detail}" var="item">
                                                <tr>
                                                    <td class="text-begin">
                                                        <c:choose>
                                                            <c:when test="${not empty item.libelle}">
                                                                ${item.libelle}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">--Non defini--</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center">
                                                        ${item.qte}
                                                    </td>
                                                    <td class="text-center">
                                                        <c:choose>
                                                            <c:when test="${not empty item.pu}">
                                                                ${item.pu}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">0</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>