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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
@RequestMapping("/demande")
public class DemandeController {
    private StatusDemandeService stdService;
    private StatusService statusService;
    private DemandeService dmdService;

    public DemandeController(StatusDemandeService stdService, StatusService statusService, DemandeService dmdService) {
        this.stdService = stdService;
        this.statusService = statusService;
        this.dmdService = dmdService;
    }

    @GetMapping("/add")
    public ModelAndView insertDemande(){
        ModelAndView model = new ModelAndView("demande/insert");
        List<Status> lsStatus = statusService.findAll();
        model.addObject("listeStatus", lsStatus);
        model.addObject("path", "add");
        model.addObject("action", "Enregistrer la demande");
        return model;
    }    
    
    @PostMapping("/add")
    public String saveDemande(Demande demande){
        StatusDemande std = new StatusDemande(demande, LocalDateTime.now());
        dmdService.insert(demande);
        stdService.insert(std);
        return "redirect:/demande/add";
    }

    @GetMapping("/update")
    public ModelAndView getMethodName(@RequestParam Integer id) {
        ModelAndView model = new ModelAndView("demande/insert");
        List<Status> lsStatus = statusService.findAll();
        Demande d = dmdService.findById(id);
        model.addObject("listeStatus", lsStatus);
        model.addObject("dmd", d);
        model.addObject("path", "update");
        model.addObject("action", "Modifier la demande");
        return model;
    }

    @PostMapping("/update")
    public String postMethodName(Demande demande) {
        return "redirect:/demande/list";
    }
    
    @GetMapping("/list")
    public ModelAndView getList() {
        ModelAndView model = new ModelAndView("demande/list");
        List<Demande> ls = dmdService.getAll();
        model.addObject("listDemande", ls);
        return model;
    }
    
    @GetMapping("/remove")
    public String remove(@RequestParam Integer id){
        dmdService.remove(id);
        return "redirect:/demande/list";
    }
}
