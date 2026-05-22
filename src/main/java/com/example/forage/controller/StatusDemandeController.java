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
    public ModelAndView getAddPage() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/statusdmd/add.jsp");
        mv.addObject("script", "std.js");
        List<Status> status = statusService.findAll();
        mv.addObject("listeStatus", status);
        return mv;
    }

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<?> submitAdd(@RequestBody StatusDemande std) {
        try {
            stdserivce.insert(std);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.CREATED).body("Status demande cree avec succes");
    }

    @GetMapping("/update")
    public ModelAndView getModifPage() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/statusdmd/update.jsp");
        mv.addObject("script", "std2.js");
        return mv;
    }

    @PostMapping("/update")
    public ResponseEntity<?> submitModif(@RequestBody StatusDemande std) {
        List<StatusDemande> ls = stdserivce.getByDemande(std.getDemande().getReference());
        int idx = 0;
        StatusDemande nextStd = null, previousStd = null;

        StatusDemande stdBeforeUpdate = stdserivce.findById(std.getId());
        if (stdBeforeUpdate.equals(std)) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body("Aucune modification n'a ete effectue");
        }
        for (int i = 0; i < ls.size(); i++) {
            if (ls.get(i).getId() == std.getId()) {
                idx = i;
                break;
            }
        }

        if (!stdBeforeUpdate.getDaty().isEqual(std.getDaty()) ) {
            Long duration = 0L;
            if (idx > 0) {
                previousStd = ls.get(idx - 1);
                if (previousStd.getDaty().isBefore(std.getDaty())) {
                    duration = std.getDiff(previousStd);

                }
            }
            if (idx < ls.size() - 1) {
                nextStd = ls.get(idx + 1);
                if (nextStd.getDaty().isAfter(std.getDaty())) {
                    duration = std.getDiff(nextStd);
                    
                }
            }
        }

        return null;
    }
}
