<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <div class="container-fluid py-4">
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <!-- Carte principale -->
                <div class="card shadow-sm">
                    <div class="card-header bg-white">
                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2">
                            <div>
                                <h1 class="h4 mb-1">${action}</h1>
                            </div>
                            <a class="btn btn-outline-secondary" href="<c:url value='/devis/list' />">
                                <i class="bi bi-list-ul me-1"></i> Voir la liste
                            </a>
                        </div>
                    </div>

                    <div class="card-body">
                        <!-- Section Devis (informations générales) -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h2 class="h5 mb-3">Devis</h2>
                                <!-- Champ Demande avec input-group -->
                                <div class="mb-3">
                                    <label for="demandeInput" class="form-label fw-semibold">Demande</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                                        <input type="text" class="form-control" id="demandeInput"
                                               name="reference" placeholder="Référence de la demande...">
                                    </div>
                                </div>

                                <!-- Formulaire principal (client, date, lieu, type) en grille -->
                                <form id="formTemp">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="client" class="form-label fw-semibold">Client</label>
                                            <input type="text" class="form-control" id="client"
                                                   name="client" placeholder="****">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="date" class="form-label fw-semibold">Date</label>
                                            <input type="date" name="createAt" class="form-control" id="date">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="lieu" class="form-label fw-semibold">Lieu</label>
                                            <input type="text" name="lieu" class="form-control"
                                                   id="lieu" placeholder="****">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="type" class="form-label fw-semibold">Type</label>
                                            <select name="type" id="type" class="form-select">
                                                <option value="DEC">devis Etude Cree</option>
                                                <option value="DEA">devis Etude Accepte</option>
                                                <option value="DER">devis Etude Refuse</option>
                                                <option value="DFC">devis Forage Cree</option>
                                                <option value="DFA">devis Forage Accepte</option>
                                                <option value="DFR">devis Forage Refuse</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Section Détail des lignes de devis -->
                        <div class="row">
                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h2 class="h5 mb-0">Détail</h2>
                                    <button id="addButton" class="btn btn-outline-primary">
                                        <i class="bi bi-plus-lg"></i> Ajouter
                                    </button>
                                </div>

                                <!-- Tableau responsive avec style Bootstrap -->
                                <div class="table-responsive">
                                    <table id="tableDevis" class="table table-striped table-bordered table-hover align-middle">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Libellé</th>
                                                <th>Qté</th>
                                                <th>PU</th>
                                                <th>Montant</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="devisBody">
                                            <!-- Ligne de saisie fixe (toujours dans le tbody) -->
                                            <tr id="inputRow" class="table-light">
                                                <td><input type="text" name="libelle" form="inputDevis" id="inputLibelle" class="form-control form-control-sm" placeholder="Libellé"></td>
                                                <td><input type="number" name="qte" form="inputDevis" id="inputQte" class="form-control form-control-sm" placeholder="Qté"></td>
                                                <td><input type="number" name="pu" form="inputDevis" id="inputPu" class="form-control form-control-sm" placeholder="PU"></td>
                                                <td></td>
                                                <td><div class="d-flex justify-content-end mt-3">
    <button id="saveDevisBtn" class="btn btn-success">Enregistrer le devis</button>
</div></td>
                                            </tr>
                                            <!-- Les lignes de devis seront injectées ici -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>