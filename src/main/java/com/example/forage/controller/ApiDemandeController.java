package com.example.forage.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.forage.entity.ApiResponse;
import com.example.forage.models.Demande;
import com.example.forage.models.Parametre;
import com.example.forage.models.StatusDemande;
import com.example.forage.service.DemandeService;
import com.example.forage.service.ParametreService;
import com.example.forage.service.StatusDemandeService;

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
        List<Parametre> retour = statusDemandeService.getAlertList(demandeService, paramService);
        ApiResponse response = new ApiResponse();
        response.setData(retour);
        response.setSuccess(true);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(response);
    }

    @GetMapping("/byref")
    @ResponseBody
    public ResponseEntity<?> getAlertByDemande(@RequestParam String ref){
        List<Demande> listeDemandes = demandeService.getAll();
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

        List<Parametre> retour = statusDemandeService.getAlertByRef(listStatus,listParametres,new ArrayList<>(),d.getId());
        response.setData(retour);
        response.setSuccess(true);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(response);
    }
}
