package com.example.forage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.forage.models.Status;
import com.example.forage.models.StatusDemande;
import com.example.forage.service.DemandeService;
import com.example.forage.service.StatusDemandeService;
import com.example.forage.service.StatusService;

@Controller
@RequestMapping("/statusdmd")
public class StatusDemandeController {
    private StatusDemandeService stdserivce;

    private DemandeService dmdsService;

    private StatusService statusService;
    
    public StatusDemandeController(StatusDemandeService stdserivce, DemandeService dmdsService,
            StatusService statusService) {
        this.stdserivce = stdserivce;
        this.dmdsService = dmdsService;
        this.statusService = statusService;
    }

    @GetMapping("/add")
    public ModelAndView getAddPage(){
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/statusdmd/add.jsp");
        mv.addObject("script", "std.js");
        List<Status> status = statusService.findAll();
        mv.addObject("listeStatus", status);
        return mv;
    }

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<?> submitAdd(@RequestBody StatusDemande std){
        try {
            stdserivce.insert(std);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.CREATED).body("Status demande cree avec succes");
    }

    @GetMapping("/update")
    public ModelAndView getModifPage(){
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/statusdmd/update.jsp");
        return mv;
    }

    @PostMapping("/update")
    public String submitModif(){
        return "redirect:/statusdmd/update";
    }
}
