package com.example.forage.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.forage.models.Demande;
import com.example.forage.models.Status;
import com.example.forage.models.StatusDemande;
import com.example.forage.service.DemandeService;
import com.example.forage.service.StatusDemandeService;
import com.example.forage.service.StatusService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@RequestMapping("/demande")
@Controller
public class DemandeController {
    private StatusDemandeService stdService;
    private StatusService statusService;
    private DemandeService dmdService;

    public DemandeController(StatusDemandeService stdService, StatusService statusService, DemandeService dmdService) {
        this.stdService = stdService;
        this.statusService = statusService;
        this.dmdService = dmdService;
    }

    @GetMapping("add")
    public ModelAndView insertDemande(){
        ModelAndView model = new ModelAndView("demande/insert");
        List<Status> lsStatus = statusService.findAll();
        model.addObject("listeStatus", lsStatus);
        return model;
    }    
    
    @PostMapping("add")
    public String saveDemande(Demande demande){
        StatusDemande std = new StatusDemande(demande, LocalDateTime.now());
        dmdService.insert(demande);
        stdService.insert(std);
        return "redirrect:/add";
    }
}
