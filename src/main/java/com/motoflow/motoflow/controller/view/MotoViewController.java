package com.motoflow.motoflow.controller.view;

import com.motoflow.motoflow.model.Moto;
import com.motoflow.motoflow.service.MotoService;
import com.motoflow.motoflow.service.ModeloService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/motos")
public class MotoViewController {

    private final MotoService motoService;
    private final ModeloService modeloService;

    public MotoViewController(MotoService motoService, ModeloService modeloService) {
        this.motoService = motoService;
        this.modeloService = modeloService;
    }


    @GetMapping
    public String list(Model model) {
        List<Moto> motos = motoService.findAll();
        model.addAttribute("motos", motos);
        return "moto/list"; // templates/moto/list.html
    }


    @GetMapping("/new")
    public String createForm(Model model) {
        model.addAttribute("moto", new Moto());
        model.addAttribute("modelos", modeloService.findAll());
        return "moto/form"; // templates/moto/form.html
    }


    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Moto moto = motoService.findById(id).orElseThrow(() -> new RuntimeException("Moto não encontrada"));
        model.addAttribute("moto", moto);
        model.addAttribute("modelos", modeloService.findAll());
        return "moto/form";
    }


    @PostMapping("/save")
    public String save(@ModelAttribute Moto moto) {
        motoService.save(moto);
        return "redirect:/motos";
    }


    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        motoService.delete(id);
        return "redirect:/motos";
    }
}
