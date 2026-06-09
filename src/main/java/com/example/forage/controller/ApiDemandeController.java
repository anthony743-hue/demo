package com.example.forage.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.forage.entity.ApiResponse;
import com.example.forage.entity.DemandeEntity;
import com.example.forage.models.Demande;
import com.example.forage.models.Parametre;
import com.example.forage.models.StatusDemande;
import com.example.forage.service.DemandeService;
import com.example.forage.service.ParametreService;
import com.example.forage.service.StatusDemandeService;

@RestController
@RequestMapping("/apiDemande")
public class ApiDemandeController {
    private StatusDemandeService statusDemandeService;
    private ParametreService paramService;
    private DemandeService demandeService;

    public ApiDemandeController(StatusDemandeService statusDemandeService, ParametreService paramService,
            DemandeService demandeService) {
        this.statusDemandeService = statusDemandeService;
        this.paramService = paramService;
        this.demandeService = demandeService;
    }

    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<?> getAlertList() {
        List<DemandeEntity> retour = new ArrayList<>();
        List<Demande> d = demandeService.getAll();
        List<StatusDemande> listeStatus = statusDemandeService.getAll();
        List<Parametre> listeParametres = paramService.getAll();
        StatusDemande std = null;
        Demande demande = null;
        DemandeEntity de = null;
        Long s = 0L;

        ApiResponse response = new ApiResponse();
        List<Parametre> listeAlerte = null;
        System.out.println("Nombre de parametres " + listeParametres.size());

        try {
            for (int i = 0; i < d.size(); i++) {
                demande = d.get(i);
                
                if (demande.getStatus().getSigle().equals("FT")) {
                    s = 0L;
                    for (int j = 0; j < listeStatus.size(); j++) {
                        std = listeStatus.get(j);
                        if ( std.getDemande().getId() == demande.getId() &&  std.getDt() != null) {
                            s += std.getDt();
                        }
                    }
                }
                de = new DemandeEntity(demande);
                de.setTotalTravaille(s / 60);
                listeAlerte = statusDemandeService.getAlertByRef(listeStatus, listeParametres, new ArrayList<>(),demande.getId());
                de.setListeAlerte(listeAlerte);
                retour.add(de);
            }
            response.setData(retour);
            response.setSuccess(true);
        } catch (Exception e) {
            response.setSuccess(false);
            response.setMessage(e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }        
       
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(response);
    }

    @GetMapping("/byref")
    @ResponseBody
    public ResponseEntity<?> getAlertByDemande(@RequestParam String ref) {
        List<Parametre> listParametres = paramService.getAll();
        List<StatusDemande> listStatus = statusDemandeService.getAll();

        ApiResponse response = new ApiResponse();
        Demande d = null;
        try {
            d = demandeService.findByReference(ref);
        } catch (Exception e) {
            response.setData(e.getMessage());
            response.setSuccess(false);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

        List<Parametre> retour = statusDemandeService.getAlertByRef(listStatus, listParametres, new ArrayList<>(),
                d.getId());
        response.setData(retour);
        response.setSuccess(true);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(response);
    }
}
